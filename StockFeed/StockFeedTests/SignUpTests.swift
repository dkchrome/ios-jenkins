//
//  SignUpTests.swift
//  StockFeedTests
//
//  Created by Deepak Kumar on 16/04/21.
//

import XCTest
@testable import StockFeed

class SignUpTests: XCTestCase {
    var signupTest: SignupViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        signupTest = SignupViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signupTest = nil
        super.tearDown()
    }

    func testValidation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        signupTest.name = ""
        signupTest.email = ""
        signupTest.password = ""
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.signupTest.usernameMessage, nameEmptyMsg, "Empty error")
            XCTAssertFalse(self.signupTest.isFormValid)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        
        signupTest.name = "test"
        signupTest.email = "abc@sdfds"
        signupTest.password = "asdf"
        
        let expectation1 = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.signupTest.emailMessage, emailInvalidMsg, "email error")
            
            expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 1.0)
        
        
        signupTest.name = "test"
        signupTest.email = "abc@sdfds.com"
        signupTest.password = "abcd"
        
        let expectation2 = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.signupTest.passwordMessage, passwordInvalidMsg, "password error")
            XCTAssertFalse(self.signupTest.isFormValid)
            
            expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 1.0)
    }
    
    func testPositiveValidation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        signupTest.name = "User"
        signupTest.email = "abc@gmail.com"
        signupTest.password = "asdf1234"
        
        let expectation = XCTestExpectation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.signupTest.isFormValid)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
    }

}
