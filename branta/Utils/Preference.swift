//
//  Preferences.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Foundation

class Preferences {
    private static let KEY = "Branta_Prefs"
    private static let DEFAULT_SCAN_CADENCE = 60.0
    
    // TODO - defaults, but read and overwrite from storage on launch
    private static var prefHash : [String:Any] = [
        // Clipboard
        "notifyForBTCAddress": true,
        "notifyForSeed": true,
        "notifyForXPub": true,
        "notifyForXPrv": true,
        "notifyForNPub": true,
        "notifyForNSec": true,
        // Wallet
        "runEvery": DEFAULT_SCAN_CADENCE,
        "notifyUponLaunch": true,
        "notifyUponStatusChange": true
    ]
    
    // TOP LEVEL READ / WRITE
    
    static func saveToDefaults() {
        UserDefaults.standard.set(toJSON(), forKey: KEY)
    }
    
    static func readFromDefaults() -> String {
        if let v = UserDefaults.standard.string(forKey: KEY) {
            return v
        } else {
            print("No string found for key \(KEY) in UserDefaults.")
            return ""
        }
    }
    
    // SETTERS
    
    static func set(key: String, value: Any) {
        // TODO.... filter keys
        prefHash[key] = value
    }
    
    private
    
    static func toJSON() -> String {
        do {
            let json = try JSONSerialization.data(withJSONObject: prefHash, options: [])
            if let str = String(data: json, encoding: .utf8) {
                return str
            }
        } catch {
            print("Error converting prefHash to JSON: \(error)")
        }
        
        return ""
    }
}
