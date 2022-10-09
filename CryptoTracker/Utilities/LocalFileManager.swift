//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/8/22.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let insatnce = LocalFileManager()
    
    private init() { }
    
    func saveCoinImage(image: UIImage, folderName: String, imageName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url = getImageLocation(folderLocation: folderName, imageName: imageName) else { return }
                
        do {
            try data.write(to: url)
        } catch {
            print("error occured while saving image: \(error) for \(imageName) in \(folderName)")
        }
        
    }
    
    func getSavedCoinImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getImageLocation(folderLocation: folderName, imageName: imageName),
              FileManager.default.fileExists(atPath: url.path) else { return nil }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        
        guard let url = getFolderLocation(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print("Given patch doen't exist: \(folderName). \(error)")
            }
        }
    }
    
    private func getFolderLocation(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil}
        return url.appending(path: folderName)
    }
    
    private func getImageLocation(folderLocation: String, imageName: String) -> URL? {
        guard let path = getFolderLocation(folderName: folderLocation) else { return nil }
        return path.appending(path: imageName + ".png")
    }
}
