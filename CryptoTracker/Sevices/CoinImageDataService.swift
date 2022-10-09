//
//  CoinImageDataService.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/2/22.
//

import Foundation
import SwiftUI
import Combine

class CoinImageDataService {
    
    @Published var image: UIImage?
    
    var coinImageCancellable: AnyCancellable?
    
    init(for coin: CoinModel) {
        fetchImage(for: coin)
    }
    
    private func fetchImage(for coin: CoinModel) {
        guard let url = URL(string: coin.image) else {
            return
        }
        coinImageCancellable = NetworkingManager.downloadDataFrom(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.coinImageCancellable?.cancel()
            }

    }
}
