//
//  Ledger.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

import Foundation

/*
 Note - Ledger uses universal binary. These hashes are same across x86/arm
 
 $ lipo -archs Ledger\ Live
 x86_64 arm64
 */

class Ledger: Wallet {
    
    override class func runtimeName() -> String {
        return "Ledger Live"
    }
    
    override class func name() -> String {
        return "Ledger Live.app"
    }
    
    override class func singleBinary() -> Bool {
        return true
    }
}
