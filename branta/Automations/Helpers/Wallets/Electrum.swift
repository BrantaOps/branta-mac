//
//  Electrum.swift
//  Branta
//
//  Created by Keith Gardner on 1/30/24.
//

import Foundation

class Electrum: Wallet {
    override class func runtimeName() -> String {
        return ""
    }
    
    override class func name() -> String {
        return ""
    }
    
    override class func x86() -> [String:String] {
        return [:]
    }
    
    override class func arm() -> [String:String] {
        return [:]
    }
}
