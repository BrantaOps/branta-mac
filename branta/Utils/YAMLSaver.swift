//
//  YAMLSaver.swift
//  Branta
//
//  Created by Keith Gardner on 4/20/24.
//

import Foundation

class YAMLSaver {
    static func saveYAMLToLocal(yamlString: String, filename: String) {
        BrantaLogger.log(s: "Attempting to save local yaml... \(filename)")
        
        if let appSupportDir: URL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let brantaURL: URL = appSupportDir.appendingPathComponent("Branta")
            
            if !FileManager.default.fileExists(atPath: brantaURL.path) {
                do {
                    try FileManager.default.createDirectory(at: brantaURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    BrantaLogger.log(s: "Error creating Application\\ Support/Branta: \(error)")
                }
            }
            
            let fullPath: URL = brantaURL.appendingPathComponent(filename)
            
            do {
                try yamlString.write(to: fullPath, atomically: true, encoding: .utf8)
                BrantaLogger.log(s: "YAML file saved successfully. \(brantaURL)")
            } catch {
                BrantaLogger.log(s: "Error saving YAML file: \(error)")
            }
        } else {
            BrantaLogger.log(s: "Application Support directory not found.")
        }
    }
    
    static func readYAMLFromLocal(filename: String) -> String? {
        
        if let appSupportDir: URL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let brantaURL: URL = appSupportDir.appendingPathComponent("Branta")
            
            if !FileManager.default.fileExists(atPath: brantaURL.path) {
                do {
                    try FileManager.default.createDirectory(at: brantaURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    BrantaLogger.log(s: "Error creating Application\\ Support/Branta: \(error)")
                }
            }
            
            let fullPath: URL = brantaURL.appendingPathComponent(filename)
            
            do {
                let yamlString = try String(contentsOf: fullPath, encoding: .utf8)
                BrantaLogger.log(s: "YAML read from disk successfully. \(fullPath).")
                return yamlString
            } catch {
                BrantaLogger.log(s: "Error reading YAML file: \(error)")
                return nil
            }
        } else {
            BrantaLogger.log(s: "Application Support directory not found.")
            return nil
        }
    }
}
