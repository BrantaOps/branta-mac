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

class MockDataFeedObserver: DataFeedObserver {
    var executionStartedCalled = false
    var receivedStartedValue: Bool?
    var countCalled = false
    var receivedCountValue: Int?
    
    func dataFeedExecutionStarted(started: Bool) {
        executionStartedCalled = true
        receivedStartedValue = started
    }
    
    func dataFeedCount(count: Int) {
        countCalled = true
        receivedCountValue = count
    }
}

class DataFeedObserverTests: XCTestCase {
    
    func testDataFeedExecutionStarted() {
        let mockObserver = MockDataFeedObserver()
        mockObserver.dataFeedExecutionStarted(started: true)
        
        XCTAssertTrue(mockObserver.executionStartedCalled)
        XCTAssertEqual(mockObserver.receivedStartedValue, true)
    }
    
    func testDataFeedCount() {
        let mockObserver = MockDataFeedObserver()
        
        let count = 10
        mockObserver.dataFeedCount(count: count)
        
        XCTAssertTrue(mockObserver.countCalled)
        XCTAssertEqual(mockObserver.receivedCountValue, count)
    }
}
