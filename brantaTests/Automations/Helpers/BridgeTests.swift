//
//  BridgeTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/8/24.
//

import XCTest
@testable import Branta

class BridgeTests: XCTestCase {
    
    func testGetRuntimeHashes() {
        XCTAssertEqual(Bridge.getRuntimeHashes().keys.count, 1)
        XCTAssertEqual(Bridge.getRuntimeHashes()["Sparrow.app"]?.keys.count, 6)
        XCTAssertEqual(Bridge.getRuntimeHashes()["Wasabi Wallet.app"]?.keys.count, nil)
    }
    
    func testGetInstallerHashes() {
        XCTAssertTrue(Bridge.getInstallerHashes().keys.count > 10)
    }
    
}
