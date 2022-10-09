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
    
    private var coinImageCancellable: AnyCancellable?
    private let fileManager = LocalFileManager.insatnce
    private let coin: CoinModel
    private let folderName = "coin_images"
    private let imageName: String
    
    init(for coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        fetchFromCache(for: coin)
    }
    
    func fetchFromCache(for coin: CoinModel) {
        
        if let image = fileManager.getSavedCoinImage(imageName: self.imageName, folderName: folderName) {
            self.image = image
            //print("Retrived From the cache \(self.imageName)")
        } else {
            downloadImage()
            //print("Image downloaded successfully! \(self.imageName)")
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: self.coin.image) else {
            return
        }
        coinImageCancellable = NetworkingManager.downloadDataFrom(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("Finished successfully!")
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let uiImage = returnedImage else { return }
                self.image = uiImage
                self.coinImageCancellable?.cancel()
                self.fileManager.saveCoinImage(image: uiImage, folderName: self.folderName, imageName: self.imageName)
            }

    }
}
