//
//  SparrowTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import XCTest
@testable import Branta

class SparrowTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Sparrow.name(), "Sparrow.app", "Name method should return")
    }
}
