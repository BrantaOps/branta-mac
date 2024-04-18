//
//  LocalInstallers.swift
//  Branta
//
//  Created by Keith Gardner on 4/13/24.
//

import Foundation
import Yams

extension Bridge {
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
}
