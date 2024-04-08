//
//  HashGrabberTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/8/24.
//

import XCTest
@testable import Branta

class HashGrabberTests: XCTestCase {
    
    func testGetRuntimeHashes() {
        XCTAssertEqual(HashGrabber.getRuntimeHashes().keys.count, 6)
        XCTAssertEqual(HashGrabber.getRuntimeHashes()["Blockstream Green.app"]?.keys.count, 6)
        XCTAssertEqual(HashGrabber.getRuntimeHashes()["Wasabi Wallet.app"]?.keys.count, 3)
    }
    
    func testGetInstallerHashes() {
        XCTAssertEqual(HashGrabber.getInstallerHashes().keys.count, 6)
    }
    
}
