//
//  Wallet.swift
//  branta
//
//  Created by Keith Gardner on 11/17/23.
//
//

import Foundation

class Wallet {
    
    // Name in motion
    // (Grep all PIDs by this string to find child PIDS)
    // (If there are exceptions to this, subclass)
    class func runtimeName() -> String {
        return "Implement me"
    }
    
    // Name at Rest
    class func name() -> String {
        return "Implement me.app"
    }
    
    // Version:SHA256 for Intel Executables
    class func x86() -> [String:String] {
        return [:]
    }
    
    // Version:SHA256 for Apple Silicon Executables
    class func arm() -> [String:String] {
        return [:]
    }
    
    class func CFBundleExecutable() -> String {
        return ""
    }
    
    // (SHA256 or SHA512):Installer File
    class func installerHashes() -> [String:String] {
        return [:]
    }
    
    class func singleBinary() -> Bool {
        return false
    }
}
