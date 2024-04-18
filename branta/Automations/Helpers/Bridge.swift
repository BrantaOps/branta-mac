//
//  Bridge.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Foundation
import Yams

class Bridge {
    private static let url = "https://hash-server-7be6da1b0395.herokuapp.com"
    private static let endpoint = "/installer_hashes"
    
    private static var runtimeHashes:[String : [String:String]]?
    private static var installerHashes:[String:String]?
    
    static func fetchLatest() {
        
        fetchLatestInstallerHashes { success in
            if success {
                BrantaLogger.log(s: "Successfully fetched latest installer hashes.")
            } else {
                installerHashes = localInstallerHashes()
                BrantaLogger.log(s: "Could not fetch latest installer hashes; falling back to local data.")
            }
        }
        
        fetchLatestRuntimeHashes { success in
            if success {
                BrantaLogger.log(s: "Succesfully fetched latest runtime hashes.")
            } else {
                runtimeHashes = localRuntimeHashes()
                BrantaLogger.log(s: "Could not fetch latest runtime hashes; falling back to local data.")
            }
        }
    }
    
    static func getRuntimeHashes() -> [String : [String:String]] {
        return runtimeHashes!
    }
    
    static func getInstallerHashes() -> [String:String] {
        return installerHashes!
    }
    
    private
    
    static func fetchLatestInstallerHashes(completion: @escaping (Bool) -> Void) {
        guard let baseURL = URL(string: url) else {
            // TODO
            fatalError("Invalid base URL")
        }
        let fullURL = baseURL.appendingPathComponent(endpoint)
        
        API.send(url: fullURL, method: "GET", body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    if let yamlString = String(data: data, encoding: .utf8) {
                        installerHashes = try Yams.load(yaml: yamlString) as? [String: String] ?? [:]
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
    
    static func fetchLatestRuntimeHashes(completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    
    static func localInstallerHashes() -> [String:String] {
        let path = Bundle.main.path(forResource: "InstallerHashes", ofType: "yaml")

        do {
            guard let path = path else {
                return [:]
            }

            let yamlString = try String(contentsOfFile: path, encoding: .utf8)
            let yamlData = try Yams.load(yaml: yamlString)

            guard let yamlDictionary = yamlData as? [String: String] else {
                return [:]
            }

            return yamlDictionary
        } catch {
            return [:]
        }
    }
    
    static func localRuntimeHashes() -> [String: [String:String]]{
        if Architecture.isArm() {
            return loadArm()
        } else if Architecture.isIntel() {
            return loadX86()
        }
        else {
            return [:]
        }
    }
    
    static func loadArm() -> [String: [String:String]] {
        return [
            Sparrow.name():               Sparrow.arm(),
            Whirlpool.name():             Whirlpool.arm()
        ]
    }
    
    static func loadX86() -> [String : [String : String]]  {
        return [
            Sparrow.name():               Sparrow.x86(),
            Whirlpool.name():             Whirlpool.x86()
        ]
    }
}
