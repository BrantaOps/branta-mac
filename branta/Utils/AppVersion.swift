//
//  AppVersion.swift
//  Branta
//
//  Created by Keith Gardner on 4/23/24.
//

import Foundation

class AppVersion {
    
    static func get(atPath appPath: String) -> String {
        let infoPlistPath = appPath + "/Contents/Info.plist"
        var key = "CFBundleShortVersionString"

        // A few wallets (Blockstream Green) use CFBundleVersion. Display that to user.
        for item in USE_SHORT_VERSION_PATH {
            if appPath.contains(item) {
                key = "CFBundleVersion"
            }
        }

        guard let infoDict = NSDictionary(contentsOfFile: infoPlistPath),
              let version = infoDict[key] as? String else {
            return "nil"
        }

        return version
    }

}
