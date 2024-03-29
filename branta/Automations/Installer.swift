//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//

import Foundation

class Installer: Automation {
    class func check(path: String) -> (Bool, String) {
        
        let hash256 = sha256(at: path)
        let hash512: String = sha512(at: path)
        let hash512Data: Data = sha512(at: path)
        let base64 = hash512Data.base64EncodedString()
        
        for app in APPS {
            // TODO - this needs to be optimized.
            let match = HashGrabber.installerHashMatches(hash256: hash256, hash512: hash512, base64: base64, wallet: app)
            if match {
                return (true, app)
            }
        }
        return (false, "")
    }
}
