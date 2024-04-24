//
//  Verify.swift
//  branta
//
//  Created by Keith Gardner on 11/20/23.
//

import Cocoa

// TODO - this class needs clean up.
class Verify: Automation {
    
    private static var alreadyWarned = [Sparrow.name(): false]
    private static let TARGETS = [Sparrow.name(): Sparrow.self]
    private static let appDelegate = NSApp.delegate as? AppDelegate
    
    private static var crawledWallets: [CrawledWallet] = [] {
        didSet {
            notifyObservers()
        }
    }
    
    // TODO - update cadence without restart
    override class func run() {
        let cadence = Settings.readFromDefaults()[SCAN_CADENCE] as! Double
        
        Timer.scheduledTimer(withTimeInterval: cadence, repeats: true) { _ in
            verify()
        }
    }
    
    static func verify() {
        let wallets = crawl()
        crawledWallets = matchSignatures(wallets: wallets)
    }
    
    static func verify(wallet: String) -> Bool {
        var exePath = wallet
        
        if TARGETS[wallet + ".app"]!.CFBundleExecutable() != "" {
            exePath = TARGETS[wallet + ".app"]!.CFBundleExecutable()
        }
        
        let fullPath = "/Applications/" + wallet + ".app/Contents/MacOS/" + exePath
        let hash = Sha.sha256(at: fullPath)
        
        return Matcher.checkRuntime(hash: hash, wallet: "\(wallet).app")
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
                if kv.value == wallet.entrySHA256 {
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
                    appDelegate?.notificationManager?.showNotification(
                        title: "Could not verify \(name)",
                        body: "",
                        key: NOTIFY_UPON_STATUS_CHANGE
                    )
                    alreadyWarned[wallet.fullWalletName] = true
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
                if TARGETS.keys.contains(item) {
                    
                    // Some Wallets use custom unix binary entry points
                    // This may be irrelevant after we hash entire dir.
                    var exePath = ""
                    if TARGETS[item]!.CFBundleExecutable() != "" {
                        exePath = TARGETS[item]!.CFBundleExecutable()
                    }
                    else {
                        exePath = String(item.dropLast(4))
                    }
                    
                    let fullPath = "/Applications/" + item + "/Contents/MacOS/" + exePath
                    let hash = Sha.sha256(at: fullPath)
                    let version = AppVersion.get(atPath: ("/Applications/" + item))
                    
                    let crawledWallet = CrawledWallet(
                        fullWalletName: item,
                        installPath: fullPath,
                        entrySHA256: hash,
                        venderVersion: version,
                        directorySHA256: "",
                        brantaSignatureMatch: false
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
