//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Vegesna, Vijay Varma on 10/2/22.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case unKnown
        
        var errorDescription: String? {
            
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from the URL: \(url)"
            case .unKnown:
                return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func downloadDataFrom(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap( { try handleURLResponse(output: $0, url: url)} )
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300  else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }
}
