//
//  BrantaViewControllerTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//


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
}
