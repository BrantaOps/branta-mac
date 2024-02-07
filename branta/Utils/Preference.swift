//
//  Preferences.swift
//  Branta
//
//  Created by Keith Gardner on 2/2/24.
//

import Foundation

let NOTIFY_FOR_BTC_ADDRESS = "notifyForBTCAddress"
let NOTIFY_FOR_SEED = "notifyForSeed"
let NOTIFY_FOR_XPUB = "notifyForXPub"
let NOTIFY_FOR_XPRV = "notifyForXPrv"
let NOTIFY_FOR_NPUB = "notifyForNPub"
let NOTIFY_FOR_NSEC = "notifyForNSec"
let SCAN_CADENCE = "scanCadence"
let NOTIFY_UPON_LAUNCH = "notifyUponLaunch"
let NOTIFY_UPON_STATUS_CHANGE = "notifyUponStatusChange"

class Preferences {
    private static let KEY = "Branta_Prefs"
    private static let DEFAULT_SCAN_CADENCE = 60.0

    // TODO - defaults, but read and overwrite from storage on launch
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
        NOTIFY_UPON_LAUNCH: true,
        NOTIFY_UPON_STATUS_CHANGE: true
    ]
        
    static func saveToDefaults() {
        UserDefaults.standard.set(toJSON(), forKey: KEY)
    }
    
    static func readFromDefaults() -> [String: Any] {
        if let v = UserDefaults.standard.string(forKey: KEY) {
            guard let jsonData = v.data(using: .utf8) else {
                print("Failed to convert JSON string to Data")
                return [:]
            }

            do {
                if let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return dict
                } else {
                    print("Failed to convert JSON to Dictionary")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        } else {
            print("No string found for key \(KEY) in UserDefaults.")
        }
        return [:]

    }
    
    // SETTERS
    
    static func set(key: String, value: Any) {
        // TODO.... filter keys
        print("Preferences.swift setting \(key):\(value)")
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
