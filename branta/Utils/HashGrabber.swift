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
    private static var hashes: [[String : [String : String]]] = []
    
    private static let x86_HASHES = [
        [ BLOCKSTREAM_GREEN:    BlockstreamGreen.x86() ],
        [ SPARROW:              Sparrow.x86() ],
        [ TREZOR:               Trezor.x86() ],
        [ LEDGER:               Ledger.x86() ]
    ]
    
    private static let arm_HASHES = [
        [ BLOCKSTREAM_GREEN:    BlockstreamGreen.arm() ],
        [ SPARROW:              Sparrow.arm() ],
        [ TREZOR:               Trezor.arm()],
        [ LEDGER:               Ledger.arm() ]
    ]
    
    static func grab() -> [[String : [String : String]]] {
        if hashes != [] { return hashes }
            
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
