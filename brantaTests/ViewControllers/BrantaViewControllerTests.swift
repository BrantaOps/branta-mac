//
//  BrantaViewControllerTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import Foundation

import XCTest
@testable import Branta

class BrantaViewControllerTests: XCTestCase {
    
    func testDelegates() {
        let brantaViewController = BrantaViewController()
        XCTAssertTrue(brantaViewController is NSViewController, "BrantaViewController should conform to NSViewController")
        XCTAssertTrue(brantaViewController is VerifyObserver, "BrantaViewController should conform to VerifyObserver")
        XCTAssertTrue(brantaViewController is NSTableViewDelegate, "BrantaViewController should conform to NSTableViewDelegate")
        XCTAssertTrue(brantaViewController is NSTableViewDataSource, "BrantaViewController should conform to NSTableViewDataSource")
    }
    
    func testCompareVersions() {
        let brantaViewController = BrantaViewController()

        XCTAssertEqual(compareVersions("1.2.3", "1.2.3"), .orderedSame, "Versions should be considered equal")
        XCTAssertEqual(compareVersions("1.2.3", "1.2.4"), .orderedAscending, "Version 1 should be less than Version 2")
        XCTAssertEqual(compareVersions("1.2.4", "1.2.3"), .orderedDescending, "Version 1 should be greater than Version 2")
        XCTAssertEqual(compareVersions("1.2", "1.2.3"), .orderedAscending, "Version with fewer components should be less")
        XCTAssertEqual(compareVersions("1.2.3", "1.2.3.1"), .orderedAscending, "Version 1 should be less than Version 2")
    }
}
