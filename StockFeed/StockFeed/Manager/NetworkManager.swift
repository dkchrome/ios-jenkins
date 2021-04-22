//
//  NetworkManager.swift
//  StockFeed
//
//  Created by Deepak Kumar on 14/04/21.
//

import Foundation
import Combine

class NetworkManager: NSObject {
    private enum Error: Swift.Error {
        case invalidResponse(URLResponse)
        case invalidData
    }
    
    @Published var isLoading = false
    
    func getRequest(url: String = "") -> AnyPublisher<Data, Swift.Error> {
        isLoading = true
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap { [weak self] data, response-> Data in
                guard let weakSelf = self else { throw Error.invalidData }
                weakSelf.isLoading = false
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw Error.invalidResponse(response)
                }
                return data
            }.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
