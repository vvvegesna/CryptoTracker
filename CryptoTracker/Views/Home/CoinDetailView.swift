//
//  CoinDetailView.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 11/18/22.
//

import SwiftUI

struct CoinDetailView: View {
    
    let coin: CoinModel
    
    init(_ coin: CoinModel) {
        self.coin = coin
        print("Initialize detail view for \(coin.name)")
    }

    var body: some View {
        Text(coin.name)
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(dev.coin)
    }
}
