//
//  HomeListViewModel.swift
//  StockFeed
//
//  Created by Deepak Kumar on 14/04/21.
//

import Foundation
import Combine

class HomeListViewModel: ObservableObject {
    let url = "\(Constants.Api.baseurl)symbols=AAPL,TSLA,GOGL&apikey=\(Constants.Api.apiKey)"
    
    @Published var items: [Stock] = []
    var cancellable = Set<AnyCancellable>()
    
    @Published var isLoading = false
    var listHandler = NetworkManager()
    
    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        listHandler.$isLoading
            .receive(on: RunLoop.main)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    
    init() {
            isLoadingPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.isLoading, on: self)
                .store(in: &cancellable)
    }
    
    func fetchStocks() {
        let stocksData = listHandler.getRequest(url: url)
        
        stocksData.sink { (completion) in
            
        } receiveValue: { [weak self] (data) in
            self?.items = StockDataStore.parseJsonData(data: data)
        }.store(in: &cancellable)
    }
    
    func logout() {
        DataManager.shared.remveUserLoggedIn()
    }
}

class StockViewModel: NSObject {
    private var stock: Stock?
    
    init(with stock: Stock?) {
        self.stock = stock
    }
    
    var stockSymbol: String {
        return stock?.symbol ?? ""
    }
    
    var stockAsk: String {
        return String(format: "%.2f", stock?.ask ?? 0.0) 
    }
    
    var stockBid: Double {
        return stock?.bid ?? 0.0
    }
    
    var date: String {
        if let time = stock?.timestamp {
            //Time stamp is in milliseconds, so will get date after divide to 1000 to make seconds.
            let date = NSDate(timeIntervalSince1970: TimeInterval(time/1000))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = NSTimeZone() as TimeZone
            let localDate = dateFormatter.string(from: date as Date)
            return localDate
        }
        return ""
    }
}
