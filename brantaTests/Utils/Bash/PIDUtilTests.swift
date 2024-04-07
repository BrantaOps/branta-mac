//
//  PIDUtilTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/7/24.
//


import XCTest
@testable import Branta

class PIDUtilTests: XCTestCase {
    
    func testGetParentPIDForNonExistentApp() {
        let appName = "NonExistentApp"
        let parentPID = PIDUtil.getParentPID(appName: appName)
        XCTAssertEqual(parentPID, -1)
    }
    
    func testGetChildPIDs() {
        let parentPID = 123
        let childPIDs = PIDUtil.getChildPIDs(parentPID: parentPID)
        XCTAssertFalse(childPIDs.isEmpty)
    }
}
