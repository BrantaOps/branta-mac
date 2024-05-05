//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//

import Foundation

class Installer: InteractiveAutomation {
    
     override class func trigger(arg: Any?) -> Any? {
        let hash256: String         = Sha.sha256(at: arg as! String)
        let hash512: String         = Sha.sha512(at: arg as! String)
        let hash512Data: Data       = Sha.sha512(at: arg as! String)
        let base64                  = hash512Data.base64EncodedString()
        
        return Matcher.checkInstaller(
            hash256: hash256,
            hash512: hash512,
            base64: base64
        )
    }
}
