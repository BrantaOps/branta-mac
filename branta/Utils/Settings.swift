//
//  Settings.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Foundation

class Settings {

    private static var prefHash : [String:Any] = [
        // Clipboard
        NOTIFY_FOR_BTC_ADDRESS: true,
        NOTIFY_FOR_SEED: true,
        NOTIFY_FOR_XPUB: true,
        NOTIFY_FOR_XPRV: true,
        NOTIFY_FOR_NPUB: true,
        NOTIFY_FOR_NSEC: true,
        // Wallet
        SCAN_CADENCE: DEFAULT_SCAN_CADENCE,
        SCAN_CADENCE_WORDING: DEFAULT_SCAN_CADENCE_WORDING,
        NOTIFY_UPON_LAUNCH: true,
        NOTIFY_UPON_STATUS_CHANGE: true,
        SHOW_IN_DOCK: true,
        LAST_SYNC: "-",
        // XPUBS
        XPUBS: [] // TODO.
    ]
    
    static func readFromDefaults() -> [String: Any] {
        if let v = UserDefaults.standard.string(forKey: PREFS_KEY) {
            guard let jsonData = v.data(using: .utf8) else {
                BrantaLogger.log(s: "Failed to convert JSON string to Data")
                return [:]
            }

            do {
                if let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    prefHash = dict // Set in-memory values from persistant storage
                    return dict
                } else {
                    BrantaLogger.log(s: "Failed to convert JSON to Dictionary")
                }
            } catch {
                BrantaLogger.log(s: "Error parsing JSON: \(error)")
            }
        } else {
            BrantaLogger.log(s: "No string found for key \(PREFS_KEY) in UserDefaults.")
            return prefHash
        }
        return [:]

    }
    
    static func set(key: String, value: Any) {
        BrantaLogger.log(s: "Preferences.swift setting \(key):\(value)")
        prefHash[key] = value
        saveToDefaults()
    }
    
    private
    
    static func saveToDefaults() {
        UserDefaults.standard.set(toJSON(), forKey: PREFS_KEY)
        UserDefaults.standard.synchronize()
    }
    
    static func toJSON() -> String {
        do {
            let json = try JSONSerialization.data(withJSONObject: prefHash, options: [])
            if let str = String(data: json, encoding: .utf8) {
                return str
            }
        } catch {
            BrantaLogger.log(s: "Error converting prefHash to JSON: \(error)")
        }
        
        return ""
    }
}
