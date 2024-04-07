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
        XCTAssertEqual(try VersionComp.compare("1.0", "1.0"), .orderedSame)
        XCTAssertEqual(try VersionComp.compare("2.3.4", "2.3.4"), .orderedSame)
    }
    
    func testAscendingVersions() {
        XCTAssertEqual(try VersionComp.compare("1.0", "1.1"), .orderedAscending)
        XCTAssertEqual(try VersionComp.compare("1.9", "2.0"), .orderedAscending)
        XCTAssertEqual(try VersionComp.compare("2.3.4", "2.3.5"), .orderedAscending)
        XCTAssertEqual(try VersionComp.compare("2.3.4.5", "2.3.4.6"), .orderedAscending)
    }
    
    func testDescendingVersions() {
        XCTAssertEqual(try VersionComp.compare("1.1", "1.0"), .orderedDescending)
        XCTAssertEqual(try VersionComp.compare("2.0", "1.9"), .orderedDescending)
        XCTAssertEqual(try VersionComp.compare("2.3.5", "2.3.4"), .orderedDescending)
        XCTAssertEqual(try VersionComp.compare("2.3.4.6", "2.3.4.5"), .orderedDescending)
    }
    
    func testMixedVersions() {
        XCTAssertEqual(try VersionComp.compare("1.0.1", "1.0"), .orderedDescending)
        XCTAssertEqual(try VersionComp.compare("1.0", "1.0.1"), .orderedAscending)
        XCTAssertEqual(try VersionComp.compare("1.0.0.1", "1.0"), .orderedDescending)
        XCTAssertEqual(try VersionComp.compare("2.0", "1.9.9"), .orderedDescending)
        XCTAssertEqual(try VersionComp.compare("1.9.9", "2.0"), .orderedAscending)
        XCTAssertEqual(try VersionComp.compare("1.1.0", "1.1"), .orderedSame)
        XCTAssertEqual(try VersionComp.compare("1.1", "1.1.0"), .orderedSame)
    }
    
    func testEmptyVersions() {
        XCTAssertThrowsError(try VersionComp.compare("", ""), "Empty input should throw an error") { error in
            XCTAssertEqual(error as? VersionComparisonError, VersionComparisonError.BlankInput)
        }
        
        XCTAssertThrowsError(try VersionComp.compare("", "1.0"), "Empty input should throw an error") { error in
            XCTAssertEqual(error as? VersionComparisonError, VersionComparisonError.BlankInput)
        }
        
        XCTAssertThrowsError(try VersionComp.compare("1.0", ""), "Empty input should throw an error") { error in
            XCTAssertEqual(error as? VersionComparisonError, VersionComparisonError.BlankInput)
        }
    }
}
