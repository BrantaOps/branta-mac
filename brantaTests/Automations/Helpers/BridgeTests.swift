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
        XCTAssertEqual(Bridge.getRuntimeHashes().keys.count, 6)
        XCTAssertEqual(Bridge.getRuntimeHashes()["Blockstream Green.app"]?.keys.count, 6)
        XCTAssertEqual(Bridge.getRuntimeHashes()["Wasabi Wallet.app"]?.keys.count, 3)
    }
    
    func testGetInstallerHashes() {
        XCTAssertTrue(Bridge.getInstallerHashes().keys.count > 10)
    }
    
}
