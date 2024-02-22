//
//  sha.swift
//  Branta
//
//  Created by Keith Gardner on 2/1/24.
//

import CryptoKit
import Foundation


func sha256(at filePath: String) -> String {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    } catch {
        // TODO - need handling
        print("sha256() Error reading file: \(error)")
        return ""
    }
}

// 1. Traverse file dir and hash entire set
// 2. Combine hashes
// 3. SHA256 the combined hashes
func sha256ForDirectory(atPath path: String) -> String? {
    var concatenatedHashes = ""
    let fileManager = FileManager.default
    guard let enumerator = fileManager.enumerator(atPath: path) else {
        return nil
    }

    for e in enumerator {
        do {
            if let item = e as? String {
                let fullPath = path + "/" + item

                let isDirectory = (enumerator.fileAttributes?[.type] as? FileAttributeType) == .typeDirectory
                let isSymLink = (enumerator.fileAttributes?[.type] as? FileAttributeType) == .typeSymbolicLink
                
                if !isDirectory && !isSymLink {
                    print("Hashed: \(fullPath)")
                    let hash = sha256(at: fullPath)
                    concatenatedHashes += hash
                }
            }
        } catch {
            print("Error accessing file: \(e), error: \(error)")
        }
    }

    if let data = concatenatedHashes.data(using: .utf8) {
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    } else {
        return nil
    }
}

func sha512(at filePath: String) -> String {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        let hashed = SHA512.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    } catch {
        // TODO - need handling
        print("sha256() Error reading file: \(error)")
        return ""
    }
}

func sha512(at filePath: String) -> Data {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        let hashed = SHA512.hash(data: data)
        return Data(hashed)
    } catch {
        print("sha512() Error reading file: \(error)")
        return Data()
    }
}
