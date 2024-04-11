//
//  Bridge.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Foundation
import Yams

class Bridge {
    private static var runtimeHashes:[String : [String:String]]?
    private static var installerHashes:[String:String]?
    
    static func fetchLatest() {
        
        if fetchLatestInstallerHashes() {
            BrantaLogger.log(s: "Succesfully fetched latest installer hashes.")
        }
        else {
            installerHashes = localInstallerHashes()
            BrantaLogger.log(s: "Could not fetch latest installer hashes; falling back to local data.")
        }
        
        
        
        if fetchLatestRuntimeHashes() {
            BrantaLogger.log(s: "Succesfully fetched latest runtime hashes.")
        }
        else {
            runtimeHashes = localRuntimeHashes()
            BrantaLogger.log(s: "Could not fetch latest runtime hashes; falling back to local data.")
        }
    }
    
    static func getRuntimeHashes() -> [String : [String:String]] {
        return runtimeHashes!
    }
    
    static func getInstallerHashes() -> [String:String] {
        return installerHashes!
    }
    
    private
    
    static func fetchLatestInstallerHashes() -> Bool {
        return false
    }
    
    static func fetchLatestRuntimeHashes() -> Bool {
        return false
    }
    
    static func localInstallerHashes() -> [String:String] {
        let path = Bundle.main.path(forResource: "InstallerHashes", ofType: "yaml")

        do {
            guard let path = path else {
                return [:]
            }

            let yamlString = try String(contentsOfFile: path, encoding: .utf8)
            let yamlData = try Yams.load(yaml: yamlString)

            guard let yamlDictionary = yamlData as? [String: String] else {
                return [:]
            }

            return yamlDictionary
        } catch {
            return [:]
        }
    }
    
    static func localRuntimeHashes() -> [String: [String:String]]{
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
