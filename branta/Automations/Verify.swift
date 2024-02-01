//
//  Verify.swift
//  branta
//
//  Created by Keith Gardner on 11/20/23.
//

import Cocoa
import CryptoKit
import Foundation


class Verify: Automation {
    static var alreadyWarned = [
        Sparrow.name():             false,
        Ledger.name():              false,
        Trezor.name():              false,
        BlockstreamGreen.name():    false,
        Wasabi.name():              false,
        Whirlpool.name():           false
    ]
    
    static let TARGETS = [
        Sparrow.name():             Sparrow.self,
        Trezor.name():              Trezor.self,
        Ledger.name():              Ledger.self,
        BlockstreamGreen.name():    BlockstreamGreen.self,
        Wasabi.name():              Wasabi.self,
        Whirlpool.name():           Whirlpool.self
    ]
    
    static let USE_SHORT_VERSION_PATH = [BlockstreamGreen.name()]
    
    static let VERIFY_INTERVAL = 60.0
    static let PATH = "/Applications"
    static let FM = FileManager.default
    private static var observers = [VerifyObserver]()
    static var signatures: Array<[String: String]> = [] {
        didSet {
            notifyObservers()
        }
    }

    override class func run() {
        Timer.scheduledTimer(withTimeInterval: VERIFY_INTERVAL, repeats: true) { _ in
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
        
        let fullPath = PATH + "/" + wallet + ".app/Contents/MacOS/" + exePath
        let hash = sha256(at: fullPath)

        return HashGrabber.runtimeHashMatches(hash: hash, wallet: "\(wallet).app")
    }
    
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
    
    private

    static func matchSignatures(wallets: Array<[String: String]>) -> Array<[String: String]> {
        let architectureSpecificHashes = HashGrabber.grab()
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
                        appDelegate?.notificationManager?.showNotification(title: "Could not verify \(name)", body: "")
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
            let items = try FM.contentsOfDirectory(atPath: PATH)

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
                    
                    let fullPath = PATH + "/" + item + "/Contents/MacOS/" + exePath
                    let hash = sha256(at: fullPath)
                    let version = getAppVersion(atPath: (PATH + "/" + item))
                    
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
            print("Verify Automation: Caught an error in crawlWallets()")
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
    
    static func sha256(at filePath: String) -> String {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let hashed = SHA256.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        } catch {
            // TODO - need handling
            print("sha256() Error reading file: \(error)")
            return ""
        }
    }
}
