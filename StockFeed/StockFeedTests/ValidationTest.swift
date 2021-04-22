//
//  ValidationTest.swift
//  StockFeedTests
//
//  Created by Deepak Kumar on 20/04/21.
//

import XCTest
@testable import StockFeed

class ValidationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertFalse(Validator.isValidEmail(""))
        XCTAssertFalse(Validator.isValidEmail("abc@dfdf"))
        XCTAssertFalse(Validator.isValidEmail("abc@dfdf."))
        XCTAssertTrue(Validator.isValidEmail("abc@mail.com"))
        
        XCTAssertFalse(Validator.isAlphaNumericPassword("abcds"))
        XCTAssertFalse(Validator.isAlphaNumericPassword("123456"))
        XCTAssertTrue(Validator.isAlphaNumericPassword("abcds1234"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}