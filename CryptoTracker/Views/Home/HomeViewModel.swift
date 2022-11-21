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
    @Published var searchText: String = ""
    
    let dataService = CoinDataService()
    
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//        }
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(getFilteredCoins)
            .sink { [weak self] filteredCoins in
                self?.allCoins = filteredCoins
            }.store(in: &cancellables)
    }
    
    private func getFilteredCoins(givenText: String, givenCoins: [CoinModel]) -> [CoinModel] {
        guard !givenText.isEmpty else {
            return givenCoins
        }
        let filter = givenText.lowercased()
        return givenCoins.filter { coin in
            return coin.name.lowercased().contains(filter) ||
            coin.symbol.lowercased().contains(filter) ||
            coin.id.lowercased().contains(filter)
        }
    }
    
}
