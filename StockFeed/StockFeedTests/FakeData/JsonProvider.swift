//
//  JsonProvider.swift
//  StockFeedTests
//
//  Created by Deepak Kumar on 20/04/21.
//

import Foundation
@testable import StockFeed

class JSONProvider {
    class func jsonFileToDict(jsonName: String) -> [String: AnyObject]? {
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    return jsonResult
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    class func jsonFileToData(jsonName: String) -> Data? {
        let bundle = Bundle(for: self)
        
        if let path = bundle.path(forResource: jsonName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }

    class func getStocks() -> [Stock] {
        if let data = jsonFileToData(jsonName: "stock_data") {
            do {
                let decoder = JSONDecoder()
                let deliveries = try decoder.decode([Stock].self, from: data)
                return deliveries
            } catch {

            }
        }
        
        return []
    }

}
