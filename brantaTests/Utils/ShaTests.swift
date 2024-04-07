//
//  ShaTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/7/24.
//

import XCTest
@testable import Branta

class ShaTests: XCTestCase {
    
    func testSha256WithExistingFile() {
        let filePath = NSTemporaryDirectory().appending("test256.txt")
        let testData = "Test data".data(using: .utf8)!
        FileManager.default.createFile(atPath: filePath, contents: testData, attributes: nil)
        
        let expectedHash = "e27c8214be8b7cf5bccc7c08247e3cb0c1514a48ee1f63197fe4ef3ef51d7e6f"
        let actualHash = Sha.sha256(at: filePath)
        
        XCTAssertEqual(actualHash, expectedHash)
        
        try? FileManager.default.removeItem(atPath: filePath)
    }
    
    func testSha256WithNonExistingFile() {
        let filePath = "path/to/nonexisting/file.txt"
        let actualHash = Sha.sha256(at: filePath)
        XCTAssertEqual(actualHash, "")
    }
    
    func testSha512WithExistingFile() {
        let filePath = NSTemporaryDirectory().appending("test512.txt")
        let testData = "Test data 512".data(using: .utf8)!
        FileManager.default.createFile(atPath: filePath, contents: testData, attributes: nil)
        
        let expectedHash = "91bb8a4fe858ff064412267ba9d5530cbfeb2c007e8c394ed0228fe837b47edd19998e0b303919a28afd06daf823fab17c95ad8d613c390c57cd458e01a5ab03"
        let actualHash: String = Sha.sha512(at: filePath)
        
        XCTAssertEqual(actualHash, expectedHash)
        
        try? FileManager.default.removeItem(atPath: filePath)
    }
    
    func testSha512WithNonExistingFile() {
        let filePath = "path/to/nonexisting/file.txt"
        let actualHash: String = Sha.sha512(at: filePath)
        XCTAssertEqual(actualHash, "")
    }
}
