//
//  VersionCompTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/7/24.
//

import XCTest
@testable import Branta

class VersionCompTests: XCTestCase {
    func testEqualVersions() {
        XCTAssertEqual(try compareVersions("1.0", "1.0"), .orderedSame)
        XCTAssertEqual(try compareVersions("2.3.4", "2.3.4"), .orderedSame)
    }
    
    func testAscendingVersions() {
        XCTAssertEqual(try compareVersions("1.0", "1.1"), .orderedAscending)
        XCTAssertEqual(try compareVersions("1.9", "2.0"), .orderedAscending)
        XCTAssertEqual(try compareVersions("2.3.4", "2.3.5"), .orderedAscending)
        XCTAssertEqual(try compareVersions("2.3.4.5", "2.3.4.6"), .orderedAscending)
    }
    
    func testDescendingVersions() {
        XCTAssertEqual(try compareVersions("1.1", "1.0"), .orderedDescending)
        XCTAssertEqual(try compareVersions("2.0", "1.9"), .orderedDescending)
        XCTAssertEqual(try compareVersions("2.3.5", "2.3.4"), .orderedDescending)
        XCTAssertEqual(try compareVersions("2.3.4.6", "2.3.4.5"), .orderedDescending)
    }
    
    func testMixedVersions() {
        XCTAssertEqual(try compareVersions("1.0.1", "1.0"), .orderedDescending)
        XCTAssertEqual(try compareVersions("1.0", "1.0.1"), .orderedAscending)
        XCTAssertEqual(try compareVersions("1.0.0.1", "1.0"), .orderedDescending)
        XCTAssertEqual(try compareVersions("2.0", "1.9.9"), .orderedDescending)
        XCTAssertEqual(try compareVersions("1.9.9", "2.0"), .orderedAscending)
        XCTAssertEqual(try compareVersions("1.1.0", "1.1"), .orderedSame)
        XCTAssertEqual(try compareVersions("1.1", "1.1.0"), .orderedSame)
    }
    
    func testEmptyVersions() {
        XCTAssertThrowsError(try compareVersions("", ""), "Empty input should throw an error") { error in
            XCTAssertEqual(error as? VersionComparisonError, VersionComparisonError.BlankInput)
        }
        
        XCTAssertThrowsError(try compareVersions("", "1.0"), "Empty input should throw an error") { error in
            XCTAssertEqual(error as? VersionComparisonError, VersionComparisonError.BlankInput)
        }
        
        XCTAssertThrowsError(try compareVersions("1.0", ""), "Empty input should throw an error") { error in
            XCTAssertEqual(error as? VersionComparisonError, VersionComparisonError.BlankInput)
        }
    }
}
