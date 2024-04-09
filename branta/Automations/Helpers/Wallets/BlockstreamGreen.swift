//
//  BlockstreamGreen.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

/*
 Note - Blockstream uses universal binary. These hashes are same across x86/arm
 
 $ lipo -archs Blockstream\ Green
 x86_64 arm64
 */

class BlockstreamGreen: Wallet {
    override class func runtimeName() -> String {
        return "Blockstream Green"
    }
    
    override class func name() -> String {
        return "Blockstream Green.app"
    }
    
    override class func x86() -> [String:String] {
        return [
            "1.2.9": "6026166039a2722182fb39ea16fafb83cbcf5c0947bc79afc9a2474665820e76",
            "1.2.8": "a501734a4e2b0258dbae931c18c8255a544bce2f4c5c4bf19e4222df00f839ee",
            "1.2.7": "043c911fc32fef36ad9468a4d20f77b1bad987d25c8d40142a98065ed4d0984c",
            "1.2.6": "e3ee45b128acf07303a81609bf67cec1a6b6f6643a8402bc98609741d05bf33f",
            "1.2.5": "38250937994bf4d173d1c18874258e18ce3802806afa172ab1838409ff137716",
            "1.2.4": "66d6c4d677d2295035fd2f0e5ea38d4f04d1f6b71a8930520d3417c88111947f"
        ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "1.2.9": "6026166039a2722182fb39ea16fafb83cbcf5c0947bc79afc9a2474665820e76",
            "1.2.8": "a501734a4e2b0258dbae931c18c8255a544bce2f4c5c4bf19e4222df00f839ee",
            "1.2.7": "043c911fc32fef36ad9468a4d20f77b1bad987d25c8d40142a98065ed4d0984c",
            "1.2.6": "e3ee45b128acf07303a81609bf67cec1a6b6f6643a8402bc98609741d05bf33f",
            "1.2.5": "38250937994bf4d173d1c18874258e18ce3802806afa172ab1838409ff137716",
            "1.2.4": "66d6c4d677d2295035fd2f0e5ea38d4f04d1f6b71a8930520d3417c88111947f"
        ]
    }
    
    override class func singleBinary() -> Bool {
        return true
    }
}
