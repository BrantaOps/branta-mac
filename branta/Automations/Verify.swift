//
//  Verify.swift
//  branta
//
//  Created by Keith Gardner on 11/20/23.
//

import Cocoa

// TODO - this class needs clean up.
class Verify: BackgroundAutomation {
    
    private static var alreadyWarned = [Sparrow.name(): false]
    private static let appDelegate = NSApp.delegate as? AppDelegate
    private static var timer: Timer?
    
    private static var crawledWallets: [CrawledWallet] = [] {
        didSet {
            notifyObservers()
        }
    }
    
    override class func run() {
        
        Timer.scheduledTimer(withTimeInterval: API_CADENCE, repeats: true) { _ in
            Bridge.fetchLatest { _ in }
        }
        
        timer?.invalidate()
        let cadence = Settings.readFromDefaults()[SCAN_CADENCE] as! Double
        timer = Timer.scheduledTimer(withTimeInterval: cadence, repeats: true) { _ in
            verify()
        }
    }
    
    static func updateTimer() {
        timer?.invalidate()
        let cadence = Settings.readFromDefaults()[SCAN_CADENCE] as! Double
        timer = Timer.scheduledTimer(withTimeInterval: cadence, repeats: true) { _ in
            verify()
        }
    }
    
    static func verify() {
        let wallets = crawl()
        crawledWallets = matchSignatures(wallets: wallets)
    }
}

extension Verify {
    private static var observers = [VerifyObserver]()

    static func addObserver(_ observer: VerifyObserver) {
        observers.append(observer)
    }
    
    static func removeObserver(_ observer: VerifyObserver) {
        observers.removeAll { $0 === observer }
    }
    
    static func notifyObservers() {
        for observer in observers {
            observer.verifyDidChange(newResults: crawledWallets)
        }
    }
}

extension Verify {
    private

    static func matchSignatures(wallets: [CrawledWallet]) -> [CrawledWallet] {
        let architectureSpecificHashes: RuntimeHashType = Bridge.getRuntimeHashes()
        var ret: [CrawledWallet] = []
        
        // Mark users wallets as "match" if we have a sha.
        for wallet in wallets {
            let name = wallet.fullWalletName
            var retItem = wallet

            for kv in architectureSpecificHashes[name]! {
                if kv.value == wallet.directorySHA256 {
                    retItem.brantaSignatureMatch = true
                }
            }
            ret.append(retItem)
        }
                
        // Second pass
        // Notify if:
        // A wallet has false and has not already sent user alert
        // Branta is in background (don't notify in foreground, nothing happens)
        for wallet in ret {
                
            if !wallet.brantaSignatureMatch {
                let name = stripAppSuffix(str: wallet.fullWalletName)
                
                // Rudimentary.... we only alert user once per app start up that their wallet is not verified.
                // We can let the user decide how noisy Branta is.
                if alreadyWarned[wallet.fullWalletName] == false && !appDelegate!.foreground {
                    // Don't alert user for wallets they don't have installed.
                    if !(wallet.notFound) {
                        
                        var localizedString = ""
                        var titleString = ""
                        var bodyString = ""
                        
                        if wallet.tooNew {
                            // Reuse Table string.
                            titleString = NSLocalizedString("TableVersionTooNew", comment: "")
                            localizedString = NSLocalizedString("TableVersionTooNewMessage", comment: "")
                            bodyString = String(format: localizedString, name, name)
                        } else if wallet.tooOld {
                            // Reuse Table string.
                            titleString = NSLocalizedString("TableVersionTooOld", comment: "")
                            localizedString = NSLocalizedString("TableVersionTooOldMessage", comment: "")
                            bodyString = String(format: localizedString, name, name)
                        } else {
                            localizedString = NSLocalizedString("NotificationNoMatch", comment: "")
                            titleString = String(format: localizedString, name)
                            bodyString = NSLocalizedString("NotificationNoMatchMessage", comment: "")
                        }
                        
                        // TODO - singleton queue for notifications. This should not be a one time alert.
                        appDelegate?.notificationManager?.showNotification(
                            title: titleString,
                            body: bodyString,
                            key: NOTIFY_UPON_STATUS_CHANGE
                        )
                        alreadyWarned[wallet.fullWalletName] = true

                    }
                }
            }
        }
        
        return ret
    }
    
    static func stripAppSuffix(str: String) -> String {
        return str.replacingOccurrences(of: ".app", with: "")
    }

    static func crawl() -> [CrawledWallet] {
        var ret: [CrawledWallet] = []

        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: "/Applications")

            for item in items {
                if TARGETS.contains(item) {
                                        
                    let installPath         = "/Applications/" + item + "/Contents/MacOS/" + String(item.dropLast(4))
                    let venderVersion       = AppVersion.get(atPath: ("/Applications/" + item))
                    let directorySHA256     = Sha.sha256ForDirectory(atPath: "/Applications/" + item)
                    let hashes              = Bridge.getRuntimeHashes()[item]!
                    let versions            = hashes.keys
                    var older               = true
                    var newer               = true
                    var comparisonResult: ComparisonResult
                    
                    for brantaVersion in versions {
                        do {
                            comparisonResult = try VersionComp.compare(venderVersion, brantaVersion)
                            if comparisonResult == .orderedAscending { newer = false }
                            else if comparisonResult == .orderedDescending { older = false }
                        } catch {
                            BrantaLogger.log(s: "BrantaViewController#showDetails error: \(error)")
                        }
                    }
                                        
                    let crawledWallet = CrawledWallet(
                        fullWalletName: item,
                        installPath: installPath,
                        venderVersion: venderVersion,
                        directorySHA256: directorySHA256,
                        brantaSignatureMatch: false,
                        notFound: false,
                        tooNew: newer,
                        tooOld: older
                    )
                    ret.append(crawledWallet)
                }
            }
            
            // Add "Not Found" Row when Sparrow isn't installed.
            for target in TARGETS {
                
                if !(ret.contains { $0.fullWalletName == target }) {
                    // Inject blank crawledWallet
                    let crawledWallet = CrawledWallet(
                        fullWalletName: target,
                        installPath: "",
                        venderVersion: "",
                        directorySHA256: "",
                        brantaSignatureMatch: false,
                        notFound: true,
                        tooNew: false, // TODO
                        tooOld: false // TODO
                    )
                    ret.append(crawledWallet)
                }
            }
            
            return ret
        } catch {
            BrantaLogger.log(s: "Verify Automation: Caught an error in crawl().")
        }
        return []
    }
}
