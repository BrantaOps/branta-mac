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

func sha256ForDirectory(atPath path: String) -> String? {
    var concatenatedHashes = ""

    let fileManager = FileManager.default

    guard let enumerator = fileManager.enumerator(atPath: path) else {
        return nil
    }

    for case let fileURL as URL in enumerator {
        do {
            let resourceValues = try fileURL.resourceValues(forKeys: [.isRegularFileKey])
            if resourceValues.isRegularFile ?? false {
                let hash = sha256(at: fileURL.path)
                concatenatedHashes += hash
            }
        } catch {
            print("Error accessing file: \(fileURL.path), error: \(error)")
        }
    }

    // Hash the concatenated hashes
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
