//
//  Bridge.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Foundation

class Bridge {
    private static let runtimeHashes = loadRuntimeHashes()
    private static let installerHashes = loadInstallerHashes()
    
    static func getRuntimeHashes() -> [String : [String:String]] {
        return runtimeHashes
    }
    
    static func getInstallerHashes() -> [String : [String:String]] {
        return installerHashes
    }
    
    private
    
    static func loadInstallerHashes() -> [String: [String:String]] {
        // here we need to hit the network.
        // should the main UI say "loading?"
        return [:]
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
