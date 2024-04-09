//
//  Matcher.swift
//  Branta
//
//  Created by Keith Gardner on 4/8/24.
//

import Foundation

class Matcher {
    
    static func checkInstaller(hash256: String, hash512: String, base64: String, wallet: String) -> Bool {
        if let candidates = Bridge.getInstallerHashes()[wallet]?.keys {
            return [hash256, hash512, base64].contains(where: { candidates.contains($0) })
        }

        return false
    }
    
    static func checkRuntime(hash: String, wallet: String) -> Bool {
        return Bridge.getRuntimeHashes()[wallet]?.values.contains(hash) ?? false
    }
}
