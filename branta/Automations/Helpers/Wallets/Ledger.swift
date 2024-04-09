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
    
    override class func x86() -> [String:String] {
        return [
            "2.77.2": "fce734f4355cbfdf65523b56b6809ea0f3ae639af52a193e3b779e6ee57e535f",
            "2.73.0": "6273aba1261d9b51dba036448bef343707e410357d1120de6e8484e276d02d0d",
            "2.71.1": "9e09610feffb4223aa36184d1bd50ec9e58b262b83ef19db3eca385cea9f7a0c",
            "2.71.0": "9284b8a84c55a616da1745edbaa185bc7168784e31ead3421847ca6c9b4c34ea",
            "2.69.0": "f0b5bfc8ad1cde88e60203b7b2c18418d28757d13e17f9a904f4cfe95fe8cd0f",
            "2.68.1": "b01720c57e26950d14d76db1f7fd094d8d4bffb5390a78877edad0c975e7580f",
            "2.57.0": "6af34c160c5fca3b89ae04f911be7632dcc9005e46c3bf9fe32ee5eecc0926ff"
        ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "2.73.0": "6273aba1261d9b51dba036448bef343707e410357d1120de6e8484e276d02d0d",
            "2.71.1": "9e09610feffb4223aa36184d1bd50ec9e58b262b83ef19db3eca385cea9f7a0c",
            "2.71.0": "9284b8a84c55a616da1745edbaa185bc7168784e31ead3421847ca6c9b4c34ea",
            "2.69.0": "f0b5bfc8ad1cde88e60203b7b2c18418d28757d13e17f9a904f4cfe95fe8cd0f",
            "2.68.1": "b01720c57e26950d14d76db1f7fd094d8d4bffb5390a78877edad0c975e7580f",
            "2.57.0": "6af34c160c5fca3b89ae04f911be7632dcc9005e46c3bf9fe32ee5eecc0926ff"
        ]
    }
}
