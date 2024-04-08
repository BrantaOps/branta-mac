//
//  HashGrabber.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Cocoa
import Foundation

class HashGrabber {
    
    private static let runtimeHashes: [String : [String : String]] = loadRuntimeHashes()
    private static let installerHashes: [String: [String:String]] = loadInstallerHashes()

    static func getRuntimeHashes() -> [String : [String : String]] {
        return runtimeHashes
    }
    
    static func getInstallerHashes() -> [String : [String : String]] {
        return installerHashes
    }
    
    static func installerHashMatches(hash256: String, hash512: String, base64: String, wallet: String) -> Bool {
        
        if let candidates = installerHashes[wallet]?.keys {
            return [hash256, hash512, base64].contains(where: { candidates.contains($0) })
        }

        return false
    }
    
    static func runtimeHashMatches(hash: String, wallet: String) -> Bool {
        return runtimeHashes[wallet]?.values.contains(hash) ?? false
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
    
    static func loadRuntimeHashes() -> [String: [String:String]]{
        if Architecture.isArm() {
            return loadArm()
        } else if Architecture.isIntel() {
            return loadX86()
        }
        else {
            return [:]
        }
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
