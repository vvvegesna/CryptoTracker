//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/2/22.
//

import Foundation
import Combine

class HomeViewModle: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    let dataService = CoinDataService()
    
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//        }
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        dataService.$AllCoins
            .sink { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
            }.store(in: &cancellables)
    }
    
}
