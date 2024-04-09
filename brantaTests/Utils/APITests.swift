//
//  APITests.swift
//  BrantaTests
//
//  Created by Keith Gardner on 4/8/24.
//

import XCTest
@testable import Branta

class APITests: XCTestCase {
    func testRequestSuccess() {
        let expectation = self.expectation(description: "Request Success")
        let url = URL(string: "https://www.example.com")!
        
        API.send(url: url) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Expected non-nil data on successful request")
                expectation.fulfill()
            case .failure(_):
                XCTFail("Expected success but got failure")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
