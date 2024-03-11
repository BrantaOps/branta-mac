//
//  Updater.swift
//  Branta
//
//  Created by Keith Gardner on 3/11/24.
//

import Foundation

let FETCH_URL = "https://api.github.com/repos/brantaops/branta-mac/releases/latest"

class Updater {
    
    static func checkForUpdates(completion: @escaping (Bool) -> Void) {
        latestVersion { latestVersion in
            if let latestVersion = latestVersion {
                print("latestVersion \(latestVersion)")
                print("currentVersion() \(currentVersion())")
                if compareVersions(latestVersion, currentVersion()) == .orderedAscending {
                    print("returning true")
                    completion(true)
                    return
                }
            }
            print("returning false")
            completion(false)
        }
    }
    
    
    static func latestVersion(completion: @escaping (String?) -> Void) {
        guard let releasesURL = URL(string: FETCH_URL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: releasesURL) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil,
                  response.statusCode == 200 else {
                completion(nil)
                return
            }
            
            do {
                let releaseInfo = try JSONDecoder().decode(GitHubRelease.self, from: data)
                completion(releaseInfo.tag_name)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    static func currentVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    struct GitHubRelease: Codable {
        let tag_name: String
    }
    
}
