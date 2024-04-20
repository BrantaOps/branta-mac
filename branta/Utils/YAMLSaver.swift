//
//  YAMLSaver.swift
//  Branta
//
//  Created by Keith Gardner on 4/20/24.
//

import Foundation

class YAMLSaver {
    
    
    // TODO - use timestamp to only write on file diff.
    // TODO - handle case that the OS, User, etc, deletes this file.
    //      uncommon, but possible case. In that scenario, fall back
    //      to the
    static func saveYAMLToLocal(yamlString: String, filename: String) {
        
        // TODO - migrate to ~/Library/Application Support/branta/
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            BrantaLogger.log(s: "Failed to local Application Support Directory.")
            return
        }
        
        let fileURL = directoryURL.appendingPathComponent(filename)
        
        do {
            try yamlString.write(to: fileURL, atomically: true, encoding: .utf8)
            BrantaLogger.log(s: "YAML file saved successfully. \(directoryURL)")
        } catch {
            BrantaLogger.log(s: "Error saving YAML file: \(error)")
        }
    }
    
    
    
    static func readYAMLFromLocal(filename: String) -> String? {

        // TODO - migrate to ~/Library/Application Support/branta/
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            BrantaLogger.log(s: "Failed to local Application Support Directory.")
            return nil
        }
        
        let fileURL = directoryURL.appendingPathComponent(filename)
        
        do {
            let yamlString = try String(contentsOf: fileURL, encoding: .utf8)
            BrantaLogger.log(s: "YAML read from disk successfully. \(directoryURL).")
            return yamlString
        } catch {
            BrantaLogger.log(s: "Error reading YAML file: \(error)")
            return nil
        }
    }
}
