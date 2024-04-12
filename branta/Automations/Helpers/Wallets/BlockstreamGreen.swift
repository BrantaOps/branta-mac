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
    
    override class func singleBinary() -> Bool {
        return true
    }
}
