//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/2/22.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject private var vm: CoinImageViewModel
    
    init(_ coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(for: coin))
    }
    
    var body: some View {
        ZStack {
            if let uiImage = vm.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
