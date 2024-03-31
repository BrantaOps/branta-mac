//
//  StringExtensionTests.swift
//  Branta
//
//  Created by Keith Gardner on 3/28/24.
//

import XCTest
@testable import Branta

class StringExtensionTests: XCTestCase {

    func testRemoveExtraSpaces() {
        // Given
        let stringWithExtraSpaces = "   Hello    world  \n   How   are  you?   "
        let expectedString = " Hello world How are you? "
        
        // When
        let result = stringWithExtraSpaces.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
    }
    
    func testRemoveExtraSpaces_EmptyString() {
        // Given
        let emptyString = ""
        
        // When
        let result = emptyString.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, "")
    }
    
    func testRemoveExtraSpaces_StringWithOnlySpaces() {
        // Given
        let stringWithOnlySpaces = "      "
        
        // When
        let result = stringWithOnlySpaces.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, "")
    }
    
    func testRemoveExtraSpaces_StringWithNewlines() {
        // Given
        let stringWithNewlines = "\n\nHello\n\n\nworld\n\n\n"
        let expectedString = " Hello world "
        
        // When
        let result = stringWithNewlines.removeExtraSpaces()
        
        // Then
        XCTAssertEqual(result, expectedString)
    }
}
