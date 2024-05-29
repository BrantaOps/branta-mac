//
//  BitcoinCore.swift
//  Branta
//
//  Created by Keith Gardner on 5/28/24.
//

import Foundation

class BitcoinCore: Wallet {
    
    override class func runtimeName() -> String {
        return "Bitcoin-Qt"
    }
    
    override class func name() -> String {
        return "Bitcoin-Qt.app"
    }
    
    override class func localizedName() -> String {
        return "Bitcoin Core"
    }
}
