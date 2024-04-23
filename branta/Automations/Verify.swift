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
    
    private static let USE_SHORT_VERSION_PATH: [String] = []
    private static var signatures: Array<[String: String]> = [] {
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
        let wallets = crawlWallets()
        signatures = matchSignatures(wallets: wallets)
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
            observer.verifyDidChange(newResults: signatures)
        }
    }
    
}

extension Verify {
    private

    static func matchSignatures(wallets: Array<[String: String]>) -> Array<[String: String]> {
        let architectureSpecificHashes: RuntimeHashType = Bridge.getRuntimeHashes()
        var ret: Array<[String: String]> = []
        
        // Mark users wallets as "match" if we have a sha.
        for wallet in wallets {
            let name = wallet["name"]!
            var retItem = wallet

            for kv in architectureSpecificHashes[name]! {
                if kv.value == wallet["hash"] {
                    retItem["match"] = "true"
                }
            }
            ret.append(retItem)
        }
                
        // Second pass
        // Notify if:
        // A wallet has false and has not already sent user alert
        // Branta is in background (don't notify in foreground, nothing happens)
        for wallet in ret {
            if let match = wallet["match"] {
                if match == "false" {
                    let app = wallet["name"]!
                    let name = stripAppSuffix(str: app)
                    
                    // Rudimentary.... we only alert user once per app start up that their wallet is not verified.
                    // We can let the user decide how noisy Branta is.
                    let appDelegate = NSApp.delegate as? AppDelegate
                    if alreadyWarned[app] == false && !appDelegate!.foreground {
                        appDelegate?.notificationManager?.showNotification(
                            title: "Could not verify \(name)",
                            body: "",
                            key: NOTIFY_UPON_STATUS_CHANGE
                        )
                        alreadyWarned[app] = true
                    }
                }
            }
        }
        
        return ret
    }
    
    static func stripAppSuffix(str: String) -> String {
        return str.replacingOccurrences(of: ".app", with: "")
    }
    
    static func crawlWallets() -> Array<[String: String]> {
        var ret : Array<[String: String]> = []

        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: "/Applications")

            for item in items {
                if TARGETS.keys.contains(item) {
                    
                    // Some Wallets use custom unix binary entry points
                    var exePath = ""
                    if TARGETS[item]!.CFBundleExecutable() != "" {
                        exePath = TARGETS[item]!.CFBundleExecutable()
                    }
                    else {
                        exePath = String(item.dropLast(4))
                    }
                    
                    let fullPath = "/Applications/" + item + "/Contents/MacOS/" + exePath
                    let hash = Sha.sha256(at: fullPath)
                    let version = getAppVersion(atPath: ("/Applications/" + item))
                    
                    ret.append([
                        "name": item,
                        "path": fullPath,
                        "hash": hash,
                        "match": "false",
                        "version": version
                    ])
                }
            }
            return ret
        } catch {
            BrantaLogger.log(s: "Verify Automation: Caught an error in crawlWallets()")
        }
        return []
    }
        
    static func getAppVersion(atPath appPath: String) -> String {
        let infoPlistPath = appPath + "/Contents/Info.plist"
        var key = "CFBundleShortVersionString"
        
        // A few wallets (Blockstream Green) use CFBundleVersion. Display that to user.
        for item in USE_SHORT_VERSION_PATH {
            if appPath.contains(item) {
                key = "CFBundleVersion"
            }
        }
        
        guard let infoDict = NSDictionary(contentsOfFile: infoPlistPath),
              let version = infoDict[key] as? String else {
            return "nil"
        }
        
        return version
    }
}
