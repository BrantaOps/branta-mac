//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//


class Installer: Automation {
    
    class func check(path: String) -> (Bool, String) {
        let hash = Verify.sha256(at: path)
        print(hash)
        
        for app in APPS {
            // TODO - this needs to be a different method that sources .dmg installers.
            let match = HashGrabber.installerHashMatches(hash: hash, wallet: app)
            if match {
                print("found a match on \(app)")
                return (true, app)
            }
            else {
                print("mismatch \(app)")
            }
        }
        
        
        return (false, "")
    }
}
