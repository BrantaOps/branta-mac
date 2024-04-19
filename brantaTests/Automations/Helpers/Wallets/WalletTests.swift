//
//  WalletTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 1/12/24.
//

import Foundation

import XCTest
@testable import Branta

class WalletTests: XCTestCase {
    func testRuntimeName() {
        XCTAssertEqual(Wallet.runtimeName(), "Implement me", "Name method should return 'Implement me'")
    }
    
    func testName() {
        XCTAssertEqual(Wallet.name(), "Implement me.app", "Name method should return 'Implement me.app'")
    }
    
    func testCFBundleExecutable() {
         XCTAssertEqual(Wallet.CFBundleExecutable(), "", "CFBundleExecutable method should return an empty string")
     }
}
