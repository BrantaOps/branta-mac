//
//  UpdaterTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/7/24.
//


import XCTest
@testable import Branta

class UpdaterTests: XCTestCase {
    
    func testCheckForUpdatesWithLatestVersionAvailable() {
        let expectation = self.expectation(description: "Check for updates")
        
        Updater.checkForUpdates { (needsUpdate, latestVersion) in
//            XCTAssertTrue(needsUpdate) // TODO
            XCTAssertEqual(latestVersion, "0.0.1")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
