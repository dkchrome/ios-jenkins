//
//  HomeListViewModel.swift
//  StockFeedTests
//
//  Created by Deepak Kumar on 20/04/21.
//

import Foundation
@testable import StockFeed

extension HomeListViewModel {
    static func getStocksData() -> [Stock] {
        return JSONProvider.getStocks()
    }
}
