//
//  Wasabi.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

import Foundation

/*
 In 2023 Wasabi split out x86/arm
 $ lipo -archs wassabee
 x86_64
 */
class Wasabi: Wallet {
    override class func runtimeName() -> String {
        return "Wasabi Wallet"
    }
    
    override class func name() -> String {
        return "Wasabi Wallet.app"
    }
    
    override class func x86() -> [String:String] {
        return [
            "2.0.5": "5e20b2b1208a61c73cda86147ed06f29d961ae8f1458ecc697f7ff27f95549b9",
            "2.0.4": "9b07a8e49bc3ab38c47f7c1efa639e54c3fa665a1357f8671b14333357517008",
            "2.0.3": "5db0d4c6567478dda765d1c78034cc810620ce448c927c147b6aec54ef6a4931"
            ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "2.0.5": "30567df89e447882fcb421b0e927c73c14a6e029d5b4c1e20d4d9a64d2c79474",
            "2.0.4": "50e8892e4d4db0480d4f386d391bc65cbfaf6ba1d8cb3f595b8db05b884b9ba6",
            "2.0.3": "eb6d36be3fc5b09b53cd58fe30b587c1f1ae499595370438f5cc5fa49a2ce172"
            ]
    }
    
    // TODO - we could pull this at runtime from Info.plist > CFBundleExecutable.
    override class func CFBundleExecutable() -> String {
        return "wassabee"
    }
}
