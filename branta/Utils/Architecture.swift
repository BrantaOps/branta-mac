//
//  Architecture.swift
//  Branta
//
//  Created by Keith Gardner on 4/8/24.
//

import Foundation

class Architecture {
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
