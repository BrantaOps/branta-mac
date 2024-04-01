//
//  CommandTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 3/30/24.
//

import Foundation

import XCTest
@testable import Branta

class CommandTests: XCTestCase {

    func testRunCommandWithoutSudo() {
        let output = Command.runCommand("ls -l")
        XCTAssertNotNil(output)
        XCTAssertFalse(output!.isEmpty)
    }

    func testRunCommandWithSudo() {
        let output = Command.runCommand("ls -l", runAsSU: true)
        XCTAssertNotNil(output)
        XCTAssertFalse(output!.isEmpty)
    }

    func testRunCommandWithOutput() {
        let output = Command.runCommand("echo 'Hello, World!'")
        XCTAssertNotNil(output)
        XCTAssertEqual(output!, "Hello, World!\n")
    }

    func testRunCommandWithoutOutput() {
        let output = Command.runCommand("echo -n ''")
        XCTAssertNotNil(output)
        XCTAssertTrue(!output!.isEmpty)
    }
}
