//
//  HomeView.swift
//  StockFeed
//
//  Created by Deepak Kumar on 13/04/21.
//

import SwiftUI
import Combine


struct HomeView: View {
    @StateObject var homeListViewModel: HomeListViewModel = HomeListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                LoadingView(isShowing: .constant(homeListViewModel.isLoading)) {
                    List (homeListViewModel.items) { item in
                        StockCell(stock: StockViewModel(with: item))
                    }
                }
                
                NavigationLink(destination: LoginView()) {
                    Text(logoutTxt)
                }.simultaneousGesture(TapGesture().onEnded{
                    homeListViewModel.logout()
                })
            }
        }.navigationBarHidden(true)
        .navigationBarTitle(Text(stocksTxt))
        .onAppear(perform: {
            homeListViewModel.fetchStocks()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeListViewModel: HomeListViewModel())
    }
}

struct StockCell: View {
    private let stock: StockViewModel
    init(stock: StockViewModel) {
        self.stock = stock
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0, content: {
            Text(stock.stockSymbol).font(.headline).padding(.bottom, 10)
            HStack {
                Text("\(stock.stockAsk)")
                Text("\(stock.date)").padding(.leading, 20)
            }
        })
    }
    
}
