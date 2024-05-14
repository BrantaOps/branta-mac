//
//  Bridge.swift
//  Branta
//
//  Created by Keith Gardner on 12/28/23.
//

import Foundation
import Yams

class Bridge {
    
    // API ENDPOINTS
    private static let API_URL                      = "https://api.branta.pro/"
    private static let INSTALLER_HASHES_ENDPOINT    = "v1/installer_hashes"
    private static let RUNTIME_HASHES_ENDPOINT      = "v1/checksums"
    
    // FILE NAMES ON DISK
    private static let RUNTIME_DISK_NAME            = "branta_runtime.yaml"
    private static let INSTALLER_DISK_NAME          = "branta_installer.yaml"

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
            notifyObservers()
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


// OBSERVER ------------------------------------------------------------------------------------------
extension Bridge {
    private static var observers = [BridgeObserver]()

    static func addObserver(_ observer: BridgeObserver) {
        observers.append(observer)
    }
    
    static func removeObserver(_ observer: BridgeObserver) {
        observers.removeAll { $0 === observer }
    }
    
    static func notifyObservers() {
        let l = lastSyncTimeString()
        
        for observer in observers {
            observer.bridgeDidFetch(content: l)
        }
        
        Settings.set(key: LAST_SYNC, value: l)
    }
    
    private static func lastSyncTimeString() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateStyle     = .short
        dateFormatter.timeStyle     = .short
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = TimeZone.current

        return dateFormatter.string(from: Date())
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
                        // TODO - These two lines must be made atomic.
                        YAMLSaver.saveYAMLToLocal(yamlString: yamlString, filename: INSTALLER_DISK_NAME)
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
        var ret: InstallerHashType = [:]
        
        if let yamlStringFromDisk: String = YAMLSaver.readYAMLFromLocal(filename: INSTALLER_DISK_NAME) {
            do {
                ret = try Yams.load(yaml: yamlStringFromDisk) as! InstallerHashType
                BrantaLogger.log(s: "Bridge: Using Installer YAML from disk.")
            } catch {
            }
        }
        else {
            BrantaLogger.log(s: "Bridge: No Runtime YAML on disk. Reading from bundle.")

            let path = Bundle.main.path(forResource: "InstallerHashes", ofType: "yaml")
            
            
            do {
                guard let path = path else {
                    return ret
                }
                
                let yamlString = try String(contentsOfFile: path, encoding: .utf8)
                ret = try Yams.load(yaml: yamlString) as! InstallerHashType
            } catch {
            }
        }
        
        return ret
    }
}

// RUNTIME HASHES ------------------------------------------------------------------------------------------
extension Bridge {
    private
    
    static func fetchLatestRuntimeHashes(completion: @escaping (Bool) -> Void) {
        var components = URLComponents(string: API_URL + RUNTIME_HASHES_ENDPOINT)!
        components.queryItems = [URLQueryItem(name: "platform", value: "mac")]
        
        guard let fullURL = components.url else {
            completion(false)
            return
        }
        
        API.send(url: fullURL, method: "GET", body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    if let yamlString = String(data: data, encoding: .utf8) {
                        let yamlDict = try Yams.load(yaml: yamlString) as! [String: [String: Any]]
                        runtimeHashes = YAMLParser.parseRuntimeYAML(yamlDict: yamlDict)
                        
                        // TODO - These two lines must be made atomic.
                        YAMLSaver.saveYAMLToLocal(yamlString: yamlString, filename: RUNTIME_DISK_NAME)
                        completion(true)
                    } else{
                        completion(false)
                    }
                } catch {
                    BrantaLogger.log(s: "fetchLatestRuntimeHashes Parsing error.")
                    completion(false)
                }
            case .failure(_):
                BrantaLogger.log(s: "fetchLatestRuntimeHashes API error.")
                completion(false)
            }
        }
        
        
    }

    static func localRuntimeHashes() -> RuntimeHashType {
        var ret: RuntimeHashType = [:]
        
        
        if let yamlStringFromDisk: String = YAMLSaver.readYAMLFromLocal(filename: RUNTIME_DISK_NAME) {
            do {
                let yamlDict = try Yams.load(yaml: yamlStringFromDisk) as! [String: [String: Any]]
                ret = YAMLParser.parseRuntimeYAML(yamlDict: yamlDict)
                print(ret)
                BrantaLogger.log(s: "Bridge: Using Runtime YAML from disk.")
            } catch {
            }
        }
        else {
            BrantaLogger.log(s: "Bridge: No Runtime YAML on disk. Reading from bundle.")
            let path = Bundle.main.path(forResource: "Mac_CheckSums", ofType: "yaml")

            do {
                guard let path = path else {
                    return ret
                }
                
                let yamlString = try String(contentsOfFile: path, encoding: .utf8)
                let yamlDict = try Yams.load(yaml: yamlString) as! [String: [String: Any]]
                ret = YAMLParser.parseRuntimeYAML(yamlDict: yamlDict)
            } catch {
            }
        }

        return ret
    }
}
