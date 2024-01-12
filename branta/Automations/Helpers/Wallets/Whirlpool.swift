//
//  whirlpool.swift
//  Branta
//
//  Created by Keith Gardner on 1/11/24.
//

import Foundation

class Whirlpool: Wallet {
 
        override class func name() -> String {
            return "whirlpool-gui.app"
        }
        
        override class func x86() -> [String:String] {
            return [
                "0.10.3": "703f47cfc62fa3a5ce33be852370d4126ac5602aaa6ec01d2e7d18073c5a6e01"
                ]
        }
        
        override class func arm() -> [String:String] {
            return [:]
        }
        
//        class func CFBundleExecutable() -> String {
//            return ""
//        }
        
//        class func pgp() {
//
//        }
}
