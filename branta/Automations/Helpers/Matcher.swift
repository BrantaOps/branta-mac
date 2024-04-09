//
//  Matcher.swift
//  Branta
//
//  Created by Keith Gardner on 4/8/24.
//

import Foundation

class Matcher {
    
    static func checkInstaller(hash256: String, hash512: String, base64: String) -> Bool {
        let h = Bridge.getInstallerHashes()
        return h[hash256] != nil || h[hash512] != nil || h[base64] != nil
    }
    
    static func checkRuntime(hash: String, wallet: String) -> Bool {
        return Bridge.getRuntimeHashes()[wallet]?.values.contains(hash) ?? false
    }
}
