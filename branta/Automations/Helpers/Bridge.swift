//
//  Bridge.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Foundation
import Yams

class Bridge {
    
    private static let API_URL                      = "https://api.branta.pro/"
    private static let INSTALLER_HASHES_ENDPOINT    = "v1/installer_hashes"
    
    private static var runtimeHashes:               RuntimeHashType?
    private static var installerHashes:             InstallerHashType?
    
    static func fetchLatest(completion: @escaping (Bool) -> Void) {
        var installerSuccess = false
        var runtimeSuccess = false
        
        let group = DispatchGroup()
        
        group.enter()
        fetchLatestInstallerHashes { success in
            if success {
                BrantaLogger.log(s: "Successfully fetched installer hashes.")
            } else {
                installerHashes = localInstallerHashes()
                BrantaLogger.log(s: "Could not fetch installer hashes; falling back to local data.")
            }
            installerSuccess = true
            group.leave()
        }
        
        group.enter()
        fetchLatestRuntimeHashes { success in
            if success {
                BrantaLogger.log(s: "Succesfully fetched runtime hashes.")
            } else {
                runtimeHashes = localRuntimeHashes()
                BrantaLogger.log(s: "Could not fetch runtime hashes; falling back to local data.")
            }
            runtimeSuccess = true
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(installerSuccess && runtimeSuccess)
        }
    }
    
    static func getRuntimeHashes() -> RuntimeHashType {
        return runtimeHashes!
    }
    
    static func getInstallerHashes() -> InstallerHashType {
        return installerHashes!
    }
    
}
    
// INSTALLER HASHES ------------------------------------------------------------------------------------------
extension Bridge {
    private
    
    static func fetchLatestInstallerHashes(completion: @escaping (Bool) -> Void) {
        let fullURL = URL(string: API_URL)!.appendingPathComponent(INSTALLER_HASHES_ENDPOINT)

        API.send(url: fullURL, method: "GET", body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    if let yamlString = String(data: data, encoding: .utf8) {
                        installerHashes = try Yams.load(yaml: yamlString) as? InstallerHashType
                        completion(true)
                    } else{
                        completion(false)
                    }
                } catch {
                    BrantaLogger.log(s: "fetchLatestInstallerHashes Parsing error.")
                    completion(false)
                }
            case .failure(_):
                BrantaLogger.log(s: "fetchLatestInstallerHashes API error.")
                completion(false)
            }
        }
    }
    
    static func localInstallerHashes() -> InstallerHashType {
        let path = Bundle.main.path(forResource: "InstallerHashes", ofType: "yaml")
        var ret: InstallerHashType = [:]
        
        
        do {
            guard let path = path else {
                return ret
            }
            
            let yamlString = try String(contentsOfFile: path, encoding: .utf8)
            ret = try Yams.load(yaml: yamlString) as! InstallerHashType
        } catch {
        }
        
        return ret
    }
    
}

// RUNTIME HASHES ------------------------------------------------------------------------------------------
extension Bridge {
    private
    
    static func fetchLatestRuntimeHashes(completion: @escaping (Bool) -> Void) {
        completion(false)
    }

    static func localRuntimeHashes() -> RuntimeHashType {
        let path = Bundle.main.path(forResource: "Mac_CheckSums", ofType: "yaml")
        var ret: RuntimeHashType = [:]

        do {
            guard let path = path else {
                return ret
            }
            
            let yamlString = try String(contentsOfFile: path, encoding: .utf8)
            let yamlDict = try Yams.load(yaml: yamlString) as! [String: [String: Any]]
            ret = YAMLParser.parseRuntimeYAML(yamlDict: yamlDict)
        } catch {
        }
        
        return ret
    }
}
