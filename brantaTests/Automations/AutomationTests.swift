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
        XCTAssertNoThrow(try BackgroundAutomation.run(), "run method should be present")
        XCTAssertNoThrow(try BackgroundAutomation.disable(), "disable method should be present")
    }
}
