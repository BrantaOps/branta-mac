//
//  VerifyTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import XCTest
@testable import Branta

class VerifyTests: XCTestCase {
    func testVerifyIsSubclassOfAutomation() {
        let isSubclass = Verify.self is Automation.Type
        XCTAssertTrue(isSubclass, "Verify should be a subclass of Automation")
    }
    
    func testVerifyIsExposed() {
        XCTAssertNoThrow(try Verify.verify(), "verify should be exposed")
    }
    
    func testRunIsExposed() {
        XCTAssertNoThrow(try Verify.run(), "run should be exposed")
    }
}
