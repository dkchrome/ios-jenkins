//
//  StockFeedTests.swift
//  StockFeedTests
//
//  Created by Deepak Kumar on 13/04/21.
//

import XCTest
@testable import StockFeed

class StockFeedTests: XCTestCase {
    var sut: HomeListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = HomeListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    
    func testStocksData() {
        XCTAssert(sut.items.count == 0, "Initial data not empty")
        
        sut.items = HomeListViewModel.getStocksData()
        
        XCTAssert(sut.items.count == 3, "Received data not correct")
        let stockData = StockViewModel(with: sut.items.first)
        
        XCTAssert(stockData.stockSymbol == "AAPL", "Symbol not found")
        XCTAssert(stockData.date == "Apr 20, 2021 at 5:29:25 AM", "Date not found")
    }

}
