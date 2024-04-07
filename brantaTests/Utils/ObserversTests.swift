//
//  ObserversTests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/7/24.
//

import XCTest
@testable import Branta

class MockVerifyObserver: VerifyObserver {
    var verifyDidChangeCalled = false
    var receivedResults: [[String: String]]?
    
    func verifyDidChange(newResults: [[String: String]]) {
        verifyDidChangeCalled = true
        receivedResults = newResults
    }
}

class VerifyObserverTests: XCTestCase {
    
    func testVerifyDidChange() {
        let mockObserver = MockVerifyObserver()
        let results: [[String: String]] = [["key1": "value1"], ["key2": "value2"]]
        mockObserver.verifyDidChange(newResults: results)
        
        XCTAssertTrue(mockObserver.verifyDidChangeCalled)
        XCTAssertEqual(mockObserver.receivedResults, results)
    }
}
