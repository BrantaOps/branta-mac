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
    
    class func CFBundleExecutable() -> String {
        return ""
    }
    
    class func singleBinary() -> Bool {
        return false
    }
}
