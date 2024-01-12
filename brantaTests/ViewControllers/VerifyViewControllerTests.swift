//
//  VerifyViewControllerTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import Foundation

import XCTest
@testable import Branta

class VerifyViewControllerTests: XCTestCase {
    
    func testDelegates() {
        let verifyViewController = VerifyViewController()
        XCTAssertTrue(verifyViewController is NSViewController, "VerifyViewController should conform to NSViewController")
        XCTAssertTrue(verifyViewController is VerifyObserver, "VerifyViewController should conform to VerifyObserver")
        XCTAssertTrue(verifyViewController is NSTableViewDelegate, "VerifyViewController should conform to NSTableViewDelegate")
        XCTAssertTrue(verifyViewController is NSTableViewDataSource, "VerifyViewController should conform to NSTableViewDataSource")
    }
    
    func testCompareVersions() {
        let verifyViewController = VerifyViewController()

        XCTAssertEqual(verifyViewController.compareVersions("1.2.3", "1.2.3"), .orderedSame, "Versions should be considered equal")
        XCTAssertEqual(verifyViewController.compareVersions("1.2.3", "1.2.4"), .orderedAscending, "Version 1 should be less than Version 2")
        XCTAssertEqual(verifyViewController.compareVersions("1.2.4", "1.2.3"), .orderedDescending, "Version 1 should be greater than Version 2")
        XCTAssertEqual(verifyViewController.compareVersions("1.2", "1.2.3"), .orderedAscending, "Version with fewer components should be less")
        XCTAssertEqual(verifyViewController.compareVersions("1.2.3", "1.2.3.1"), .orderedAscending, "Version 1 should be less than Version 2")
    }
}
