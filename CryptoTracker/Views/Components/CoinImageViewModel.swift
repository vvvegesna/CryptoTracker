//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/2/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    private let coinImageService: CoinImageDataService
    
    init(for coin: CoinModel) {
        isLoading = true
        coinImageService = CoinImageDataService(for: coin)
        addSubscriber(for: coin)
    }
    
    private func addSubscriber(for coin: CoinModel) {
        coinImageService.$image
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("successful")
                    break
                case .failure(let error):
                    print("error for coin: \(error.localizedDescription)")
                }
                self?.isLoading = false
            } receiveValue: { [weak self] (uiImage) in
                self?.image = uiImage
            }
            .store(in: &cancellables)

    }
}
