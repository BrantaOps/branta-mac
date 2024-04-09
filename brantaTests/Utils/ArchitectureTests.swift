//
//  ArchitectureTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/8/24.
//

import XCTest
@testable import Branta

class ArchitectureTests: XCTestCase {
    func testIsArm() {
        XCTAssertFalse(Architecture.isArm())
    }

    func testIsIntel() {
        XCTAssertTrue(Architecture.isIntel())
    }
}
