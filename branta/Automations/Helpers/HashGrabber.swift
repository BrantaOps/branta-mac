//
//  HashGrabber.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Cocoa
import Foundation

class HashGrabber {
    
    // Memoized cache for hashes.
    private static var hashes: [String : [String : String]] = [:]
    
    // TODO - optimize.
    private static let x86_hashes = loadX86()
    private static let arm_hashes = loadArm()
    private static let installer_hashes = loadInstallerHashes()

    
    static func installerHashMatches(hash256: String, hash512: String, base64: String, wallet: String) -> Bool {
            
//        let url = URL(string: "https://api.example.com/data")!
//        API.send(url: url) { result in
//            switch result {
//            case .success(let data):
//                print("Fetched data: \(data)")
//                0
//            case .failure(let error):
//                print("Error: \(error)")
//                0
//            }
//        }
            
        if installer_hashes[wallet] != nil {
            let candidates = installer_hashes[wallet]!.keys
            return candidates.contains(hash256) || candidates.contains(hash512) || candidates.contains(base64)
        } else {
            return false
        }
    }
    
    
    static func runtimeHashMatches(hash: String, wallet: String) -> Bool {
        if hashes[wallet] != nil {
            let candidates = hashes[wallet]!.values
            return candidates.contains(hash)
        } else {
            return false
        }
    }

    static func grab() -> [String : [String : String]] {
        if hashes != [:] { return hashes }
            
        if Architecture.isArm() {
            hashes  = arm_hashes
        } else if Architecture.isIntel() {
            hashes  = x86_hashes
        }
        
        return hashes
    }
    
    private
    
    static func loadInstallerHashes() -> [String: [String:String]] {
        return [
            BlockstreamGreen.runtimeName():     BlockstreamGreen.installerHashes(),
            Sparrow.runtimeName():              Sparrow.installerHashes(),
            Trezor.runtimeName():               Trezor.installerHashes(),
            Ledger.runtimeName():               Ledger.installerHashes(),
            Wasabi.runtimeName():               Wasabi.installerHashes(),
            Whirlpool.runtimeName():            Whirlpool.installerHashes()
        ]
    }
    
    static func loadArm() -> [String: [String:String]] {
        return [
            BlockstreamGreen.name():      BlockstreamGreen.arm(),
            Sparrow.name():               Sparrow.arm(),
            Trezor.name():                Trezor.arm(),
            Ledger.name():                Ledger.arm(),
            Wasabi.name():                Wasabi.arm(),
            Whirlpool.name():             Whirlpool.arm()
        ]
    }
    
    static func loadX86() -> [String : [String : String]]  {
        return [
            BlockstreamGreen.name():      BlockstreamGreen.x86(),
            Sparrow.name():               Sparrow.x86(),
            Trezor.name():                Trezor.x86(),
            Ledger.name():                Ledger.x86(),
            Wasabi.name():                Wasabi.x86(),
            Whirlpool.name():             Whirlpool.x86()
        ]
    }
}
