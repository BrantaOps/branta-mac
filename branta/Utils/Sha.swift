//
//  sha.swift
//  Branta
//
//  Created by Keith Gardner on 2/1/24.
//

import CryptoKit
import Foundation

// Single File API
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

// Directory API
extension Sha {
    
    
    // TODO - does this exactly match command line?
    // Or does this skip symlinks whereas command line does not?
    
    // 1. Traverse directory, skip symlinks, hash files
    // 2. Combine hashes
    // 3. SHA256 the combined hashes
    class func sha256ForDirectory(atPath path: String) -> String? {
        var concatenatedHashes = ""

        guard let enumerator = FileManager.default.enumerator(atPath: path) else {
            return nil
        }

        for e in enumerator {
            if let node = e as? String {
                let fullPath = path + "/" + node

                let isDirectory = (enumerator.fileAttributes?[.type] as? FileAttributeType) == .typeDirectory
                let isSymLink = (enumerator.fileAttributes?[.type] as? FileAttributeType) == .typeSymbolicLink

                if !isDirectory && !isSymLink {
                    print("Hashing: \(fullPath)")
                    let hash = sha256(at: fullPath)
                    concatenatedHashes += hash
                }
            }
        }

        if let data = concatenatedHashes.data(using: .utf8) {
            let hashed = SHA256.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        } else {
            return nil
        }
    }
}
