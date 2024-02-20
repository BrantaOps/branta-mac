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
    
    // Standard SHA 256 from manifest
    override class func installerHashes() -> [String:String] {
        return [
            "8c53b938d616cd6d4d2c621418fe011782352e95a795a80defdc77c45fb0dc77": "Wasabi-2.0.5-arm64.dmg",
            "5a3ab59f78a155ffeddda2af7a03897cf3ed9f27027dbce5ad3a80bffa6d16ef": "Wasabi-2.0.5-linux-x64.zip",
            "b3c4dc96657a8862a9ad4b485a1d301773325d8d71c91a13c57713941be3e982": "Wasabi-2.0.5-macOS-arm64.zip",
            "e7e6de0d4304011e98ad9482404d6dd34e28e4ead3abf48763dcec877a8422cd": "Wasabi-2.0.5-macOS-x64.zip",
            "a2aff94ff2493f91b492298583836104cb03b294ad653ebc1691b9936d73350a": "Wasabi-2.0.5-win7-x64.zip",
            "ac6b3a9095e4a7d3c2407117760cfcf8b0d829fcdd67eee225a90dde784dc776": "Wasabi-2.0.5.deb",
            "67dcaf2a5d6c3e890b04812ea0a92cc3129e2c1f52879aea5487251984c62953": "Wasabi-2.0.5.dmg",
            "ab1a35ed0294340b363fd7d84568bcea8407cb35a45b5c1da8c4f811dfa963bc": "Wasabi-2.0.5.msi",
            "d40817f8a970fc8b114415763353a42c61380cfaaaea15f687bd9137369dd833": "Wasabi-2.0.5.tar.gz"
        ]
    }
}
