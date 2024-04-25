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
    
    
    // Bash:
    // find Sparrow.app/ -type f -not -type l -exec shasum -a 256 {} + | sort | cut -d' ' -f1 | tr -d '\n' | shasum -a 256
    // Skip symlinks
    // get sha256
    // Remove path, remove whitespace, remove newlines
    // sha256 the sorted hashes
    
    // Swift:
    // 1. Traverse directory, skip symlinks
    // 2. Run sha256, add to `hashes`
    // 3. Sort hashes array
    // 3. sha256 the sorted hashes
    class func sha256ForDirectory(atPath path: String) -> String {
        var hashes: [String] = []

        guard let enumerator = FileManager.default.enumerator(atPath: path) else {
            return ""
        }
        
        for e in enumerator {
            if let node = e as? String {
                let fullPath = path + "/" + node

                let isDirectory = (enumerator.fileAttributes?[.type] as? FileAttributeType) == .typeDirectory
                let isSymLink = (enumerator.fileAttributes?[.type] as? FileAttributeType) == .typeSymbolicLink

                if !isDirectory && !isSymLink {
                    let hash = sha256(at: fullPath)
                    hashes.append(hash)
                }
            }
        }
        
        hashes.sort()
        
        if let data = hashes.joined().data(using: .utf8) {
             let hashed = SHA256.hash(data: data)
             return hashed.compactMap { String(format: "%02x", $0) }.joined()
         } else {
             return ""
         }
    }
}
