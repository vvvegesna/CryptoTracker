//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/2/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModle
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                SearchBarView(searchText: $viewModel.searchText)
                List {
                    ForEach(viewModel.allCoins) { coin in
                       oldNavigationLink(for: coin)
                    }
                }.listStyle(PlainListStyle())
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    
    func oldNavigationLink(for coin: CoinModel) -> some View {
        NavigationLink {
            CoinDetailView(coin)
        } label: {
            HStack {
                CoinImageView(coin)
                    .frame(width: 30, height: 30)
                Text(coin.symbol.uppercased())
            }
        }
    }
}
