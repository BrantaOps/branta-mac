//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//

import Foundation

class Installer: Automation {
    class func check(path: String) -> Bool {
        
        let hash256: String         = Sha.sha256(at: path)
        let hash512: String         = Sha.sha512(at: path)
        let hash512Data: Data       = Sha.sha512(at: path)
        let base64                  = hash512Data.base64EncodedString()
        
        return Matcher.checkInstaller(hash256: hash256, hash512: hash512, base64: base64)
    }
}
