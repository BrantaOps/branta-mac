//
//  sha.swift
//  Branta
//
//  Created by Keith Gardner on 2/1/24.
//

import CryptoKit
import Foundation

class Sha {
    class func sha256(at filePath: String) -> String {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let hashed = SHA256.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        } catch {
            BrantaLogger.log(s: "sha256() Error reading file: \(error)")
            return ""
        }
    }
    
    class func sha512(at filePath: String) -> String {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let hashed = SHA512.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        } catch {
            BrantaLogger.log(s: "sha256() Error reading file: \(error)")
            return ""
        }
    }
    
    class func sha512(at filePath: String) -> Data {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
            let hashed = SHA512.hash(data: data)
            return Data(hashed)
        } catch {
            BrantaLogger.log(s: "sha512() Error reading file: \(error)")
            return Data()
        }
    }
}
