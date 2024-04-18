//
//  LocalRuntime.swift
//  Branta
//
//  Created by Keith Gardner on 4/13/24.
//

import Foundation
import Yams

struct RuntimeStruct {
    struct Version {
        let date: Date
        let hash: [String:String]
//        let x86: [String: String]
//        let arm: [String: String]
    }
    
    let versions: [String: Version]
}

// Local Runtime
extension Bridge {
    
    static func localRuntimeHashes() -> [String: RuntimeStruct.Version]{
        let path = Bundle.main.path(forResource: "InstallerHashes", ofType: "yaml")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        do {
            guard let path = path else {
                return [:]
            }
            
            let yamlString = try String(contentsOfFile: path, encoding: .utf8)
            let yaml = try Yams.load(yaml: yamlString) as! [String: Any]
            guard let sparrow = yaml["sparrow"] as? [String: Any] else {
                print("Failed to parse sparrow section.")
                return [:]
            }
            
            var versions = [String: RuntimeStruct.Version]()
            
            for (versionString, versionInfo) in sparrow {
                guard let versionDict = versionInfo as? [String: Any],
                      let dateString = versionDict["date"] as? String,
                      let date = dateFormatter.date(from: dateString),
                      let x86 = versionDict["x86"] as? [String: String],
                      let arm = versionDict["arm"] as? [String: String] else {
                    print("Failed to parse version \(versionString).")
                    continue
                }
                
                if Architecture.isArm() {
                    versions[versionString] = RuntimeStruct.Version(date: date, hash: arm)
                } else if Architecture.isIntel() {
                    versions[versionString] = RuntimeStruct.Version(date: date, hash: x86)
                }
            }
            
            return versions
        } catch {
            print("Error parsing YAML: \(error)")
            return [:]
        }
        
    }
}
