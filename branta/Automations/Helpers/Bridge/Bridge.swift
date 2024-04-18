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
    private static let installerEndpoint = "/installer_hashes"
    private static let checksumsEndpoint = "/mac/checksums"

    private static var runtimeHashes:[String : [String:String]]?
    private static var installerHashes:[String:String]?
    
    static func fetchLatest(completion: @escaping (Bool) -> Void) {
        var installerSuccess = false
        var runtimeSuccess = false
        
        let group = DispatchGroup()
        
        group.enter()
        fetchLatestInstallerHashes { success in
            installerSuccess = true
            if success {
                BrantaLogger.log(s: "Successfully fetched latest installer hashes.")
            } else {
                installerHashes = localInstallerHashes()
                BrantaLogger.log(s: "Could not fetch latest installer hashes; falling back to local data.")
            }
            group.leave()
        }
        
        group.enter()
        fetchLatestRuntimeHashes { success in
            runtimeSuccess = true
            if success {
                BrantaLogger.log(s: "Succesfully fetched latest runtime hashes.")
            } else {
                runtimeHashes = localRuntimeHashes()
                BrantaLogger.log(s: runtimeHashes)
                BrantaLogger.log(s: "Could not fetch latest runtime hashes; falling back to local data.")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(installerSuccess && runtimeSuccess)
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
        completion(false)
//        guard let baseURL = URL(string: url) else {
//            fatalError("Invalid base URL")
//        }
//        let fullURL = baseURL.appendingPathComponent(installerEndpoint)
//
//        API.send(url: fullURL, method: "GET", body: nil) { result in
//            switch result {
//            case .success(let data):
//                do {
//                    if let yamlString = String(data: data, encoding: .utf8) {
//                        installerHashes = try Yams.load(yaml: yamlString) as! [String: String]
//                        completion(true)
//                    } else{
//                        completion(false)
//                    }
//                } catch {
//                    BrantaLogger.log(s: "fetchLatestInstallerHashes Parsing error.")
//                    completion(false)
//                }
//            case .failure(_):
//                BrantaLogger.log(s: "fetchLatestInstallerHashes API error.")
//                completion(false)
//            }
//        }
    }
    
    static func fetchLatestRuntimeHashes(completion: @escaping (Bool) -> Void) {
        completion(false)
//        guard let baseURL = URL(string: url) else {
//            fatalError("Invalid base URL")
//        }
//        let fullURL = baseURL.appendingPathComponent(checksumsEndpoint)
//
//        API.send(url: fullURL, method: "GET", body: nil) { result in
//            switch result {
//            case .success(let data):
//                do {
//                    if let yamlString = String(data: data, encoding: .utf8) {
//                        runtimeHashes = try Yams.load(yaml: yamlString) as! [String: [String: String]]
//                        completion(true)
//                    } else{
//                        completion(false)
//                    }
//                } catch {
//                    BrantaLogger.log(s: "fetchLatestRuntimeHashes Parsing error.")
//                    completion(false)
//                }
//            case .failure(_):
//                BrantaLogger.log(s: "fetchLatestRuntimeHashes API error.")
//                completion(false)
//            }
//        }
    }
}
