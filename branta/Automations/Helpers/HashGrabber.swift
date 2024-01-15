//
//  HashGrabber.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Cocoa
import Foundation

class HashGrabber {
    
    // Memoized cache for hashes.
    private static var hashes: [String : [String : String]] = [:]
    
    private static let x86_HASHES = [
        BlockstreamGreen.name():      BlockstreamGreen.x86(),
        Sparrow.name():               Sparrow.x86(),
        Trezor.name():                Trezor.x86(),
        Ledger.name():                Ledger.x86(),
        Wasabi.name():                Wasabi.x86(),
        Whirlpool.name():             Whirlpool.x86()
    ]
    
    private static let arm_HASHES = [
        BlockstreamGreen.name():      BlockstreamGreen.arm(),
        Sparrow.name():               Sparrow.arm(),
        Trezor.name():                Trezor.arm(),
        Ledger.name():                Ledger.arm(),
        Wasabi.name():                Wasabi.arm(),
        Whirlpool.name():             Whirlpool.arm()
    ]
    
    static func hashMatches(hash: String, wallet: String) -> Bool {
        let candidates = hashes[wallet]!.values
        return candidates.contains(hash)
    }

    static func grab() -> [String : [String : String]] {
        if hashes != [:] { return hashes }
            
        if isArm() {
            hashes  = arm_HASHES
        } else if isIntel() {
            hashes  = x86_HASHES
        }
        
        return hashes
    }
    
    private
    
    static func isArm() -> Bool {
#if arch(arm64)
        return true
#endif
        return false
    }
    
    static func isIntel() -> Bool {
#if arch(x86_64)
        return true
#endif
        return false
    }
}
