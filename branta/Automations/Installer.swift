//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//

class Installer: Automation {
    class func check(path: String) -> (Bool, String) {
        
        // TODO - We can either hook here to match path to name, or run 256 & 512.
        // Compare CPU.
        let hash256 = sha256(at: path)
        let hash512 = sha512(at: path)
        
        for app in APPS {
            
            
            let match = HashGrabber.installerHashMatches(hash256: hash256, hash512: hash512, wallet: app)
            if match {
                return (true, app)
            }
        }
        return (false, "")
    }
}
