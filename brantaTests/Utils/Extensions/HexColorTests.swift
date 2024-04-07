//
//  HexColorTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/7/24.
//

import XCTest
@testable import Branta

class NSColorHexInitializationTests: XCTestCase {
    
    func testValidHexInitialization() {
        let validHexStrings = ["#FF0000", "#00FF00", "#0000FF", "#FFFFFF", "#000000", "FF0000", "123456"]
        
        for hexString in validHexStrings {
            if let color = NSColor(hex: hexString) {
                XCTAssertNotNil(color)
            } else {
                XCTFail("Failed to initialize color from valid hexadecimal string: \(hexString)")
            }
        }
    }
    
    func testInvalidHexInitialization() {
        let invalidHexStrings = ["", "XYZ123", "#123", "#ABCDEF123"]
        
        for hexString in invalidHexStrings {
            let color = NSColor(hex: hexString)
            XCTAssertNil(color, "Expected nil color for invalid hexadecimal string: \(hexString)")
        }
    }
}
