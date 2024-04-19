//
//  YAMLParser.swift
//  Branta
//
//  Created by Keith Gardner on 4/19/24.
//

import Foundation

class YAMLParser {
    
    static func parseRuntimeYAML(yamlDict: [String: [String: Any]]) -> RuntimeHashType {
        var ret: RuntimeHashType = [:]

        for (walletName, versions) in yamlDict {
            //BrantaLogger.log(s: "Debug: walletName: \(walletName)")
            //BrantaLogger.log(s: "Debug: versions: \(versions)")
            
            var walletVersions: [String:String] = [:]
            for (version, data) in versions {
                //BrantaLogger.log(s: "Debug: version: \(version)")
                //BrantaLogger.log(s: "Debug: data: \(data)")

                if let parseableData = data as? [AnyHashable: Any] {
                    
                    // Grab Intel Hash
                    if Architecture.isIntel(),
                       let x86Dict = parseableData[AnyHashable("x86")] as? [AnyHashable: Any],
                       let x86Sha256 = x86Dict[AnyHashable("sha256")] as? String {
                        //BrantaLogger.log(s: "Date: \(date)")
                        //BrantaLogger.log(s: "x86Sha256: \(x86Sha256)")
                        walletVersions[version] = x86Sha256
                    }
                    // Grab ARM Hash
                    else if Architecture.isArm(),
                       let armDict = parseableData[AnyHashable("arm")] as? [AnyHashable: Any],
                       let armSha256 = armDict[AnyHashable("sha256")] as? String {
                        //BrantaLogger.log(s: "Date: \(date)")
                        //BrantaLogger.log(s: "armSha256: \(armSha256)")
                        walletVersions[version] = armSha256
                    }

                }
            }
            ret[walletName] = walletVersions
        }
        
        return ret
    }
}
