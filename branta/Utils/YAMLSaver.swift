//
//  YAMLSaver.swift
//  Branta
//
//  Created by Keith Gardner on 4/20/24.
//

import Foundation

class YAMLSaver {
    
    
    // TODO - write on update. Not on every 200 response. Check TS for this purpose.
    static func saveYAMLFileToLocal(yamlString: String, filename: String) {
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to locate documents directory.")
            return
        }
        
        let fileURL = directoryURL.appendingPathComponent(filename)
        
        do {
            try yamlString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("YAML file saved successfully. \(directoryURL)")
        } catch {
            print("Error saving YAML file: \(error)")
        }
    }
    
    
    
    static func readYAMLFileFromLocal() -> String? {
        // Get the URL for the directory where the file is saved
        guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to locate documents directory.")
            return nil
        }
        
        // Append the file name to the directory URL
        let fileURL = directoryURL.appendingPathComponent("data.yaml")
        
        do {
            // Read the contents of the file as a string
            let yamlString = try String(contentsOf: fileURL, encoding: .utf8)
            return yamlString
        } catch {
            print("Error reading YAML file: \(error)")
            return nil
        }
    }
}
