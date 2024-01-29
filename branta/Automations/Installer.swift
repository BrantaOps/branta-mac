//
//  Installer.swift
//  Branta
//
//  Created by Keith Gardner on 1/27/24.
//

class Installer: Automation {
    class func check(path: String) -> (Bool, String) {
        let hash = Verify.sha256(at: path)
        for app in APPS {
            let match = HashGrabber.installerHashMatches(hash: hash, wallet: app)
            if match {
                return (true, app)
            }
        }
        return (false, "")
    }
}
