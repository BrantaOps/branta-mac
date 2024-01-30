//
//  AutomationTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import XCTest
@testable import Branta

class AutomationTests: XCTestCase {
    func testAutomationInterface() {
        XCTAssertNoThrow(try Automation.run(), "run method should be present")
        XCTAssertNoThrow(try Automation.disable(), "disable method should be present")
    }
}
