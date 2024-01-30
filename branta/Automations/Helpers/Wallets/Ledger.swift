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
    
    // SHA512... TODO
    override class func installerHashes() -> [String:String] {
        return [
            // 2.75.0
            "2a4e77a8de337e8d5e7bd77888da963f9de3305be7d0c9ef384724445a173e800ef87d8fb6cca02352c280f30f79c9ba8e305cb47544e5bfdf692c092e1e7628": "ledger-live-desktop-2.75.0-linux-x86_64.AppImage",
            "2f8083905223e830302fbacedf24fe75c6cbc40420b21c9befee68dabad04aac5af9ddb572231fcb00675989ea31456a13c185ef60aaf1051bc43744d8e86915": "ledger-live-desktop-2.75.0-mac.dmg",
            "ee2c9c6c40f032e2410e291040deaa1c5fb6b422c7836c9fb6ad58bc3c189ced58185c149966f62e389132f5c63aed97daffeab4ddab682844fdaa34d63d72d1": "ledger-live-desktop-2.75.0-mac.zip",
            "11289b6f800395f9a7945bedc7bd061bfd6df9ba1f6bf5af20b0f97472785a77e38f9b28c2ed6dac2efba7bfcae1b2f794767192a489ab8a1735df212bfe0889": "ledger-live-desktop-2.75.0-win-x64.exe"
        
            
        
            
        ]
        
    }
    
}
