//
//  Env.swift
//  Branta
//
//  Created by Keith Gardner on 5/27/24.
//

import Foundation

class Env {

    class func loadEnv() -> [String: String]? {
        guard let envFilePath = Bundle.main.path(forResource: ".env", ofType: nil) else {
            BrantaLogger.log(s: ".env file not found")
            return nil
        }
        
        do {
            let envFileContents = try String(contentsOfFile: envFilePath, encoding: .utf8)
            let lines = envFileContents.split { $0.isNewline }
            
            var envDict = [String: String]()
            
            for line in lines {
                let parts = line.split(separator: "=", maxSplits: 1)
                if parts.count == 2 {
                    let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
                    let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
                    envDict[key] = value
                }
            }
            
            return envDict
        } catch {
            BrantaLogger.log(s: "Error reading .env file: \(error)")
            return nil
        }
    }
}
