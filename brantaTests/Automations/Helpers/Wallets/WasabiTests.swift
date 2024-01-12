//
//  WasabiTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import XCTest
@testable import Branta

class WasabiTests: XCTestCase {
    func testName() {
        XCTAssertEqual(Wasabi.name(), "Wasabi Wallet.app", "Name method should return")
    }
}
