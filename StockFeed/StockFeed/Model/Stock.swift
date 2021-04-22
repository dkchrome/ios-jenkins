//
//  Stock.swift
//  StockFeed
//
//  Created by Deepak Kumar on 13/04/21.
//

import Foundation

struct Stock: Identifiable, Codable {
    var id: String {
        return symbol
    }
    
    let symbol: String
    let ask: Double
    let bid: Double
    let asize: Int
    let bsize: Int
    let timestamp: Int64
}

struct StockDataStore {

    static func parseJsonData(data: Data) -> [Stock] {
        var stocks = [Stock]()
     
        do {
            let decoder = JSONDecoder()
            stocks = try decoder.decode([Stock].self, from: data)
        } catch {

        }
        
        return stocks
    }
}
