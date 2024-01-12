//
//  ClipboardTests.swift
//  brantaTests
//
//  Created by Keith Gardner on 12/15/23.
//

import XCTest
@testable import Branta

class ClipboardTests: XCTestCase {
    
    // Addresses --------------------------------------------------------------------------
    func testValidateBitcoinAddress() {
        XCTAssertTrue(BitcoinAddress.isValid(str: "bc1qxp78h48nre66s2m529ey3u8lt39hesjveqtkap"))
        XCTAssertFalse(BitcoinAddress.isValid(str: "invalidBitcoinAddress"))
    }
    
    func testValidateBitcoinPrivateKey() {
        XCTAssertTrue(BitcoinAddress.isValidXPRV(str: "xprv123abcdefghijk"))
        XCTAssertFalse(BitcoinAddress.isValidXPRV(str: "123xprv123"))
    }

    func testValidateBitcoinXPUB() {
        XCTAssertTrue(BitcoinAddress.isValidXPUB(str: "xpub%%%%%%%%%"))
        XCTAssertFalse(BitcoinAddress.isValidXPUB(str: "123xprv123"))
    }

    func testNostrNPUB() {
        XCTAssertTrue(NostrAddress.isValidNPUB(str: "npub180cvv07tjdrrgpa0j7j7tmnyl2yr6yr7l8j4s3evf6u64th6gkwsyjh6w6"))
        XCTAssertFalse(NostrAddress.isValidNPUB(str: "npubkwsyjh6w6"))
    }
    
    func testNostrNSEC() {
        XCTAssertTrue(NostrAddress.isValidNSEC(str: "nsec1vl029mgpspedva04g90vltkh6fvh240zqtv9k0t9af8935ke9laqsnlfe5"))
        XCTAssertFalse(NostrAddress.isValidNSEC(str: "nsec"))
    }
}
