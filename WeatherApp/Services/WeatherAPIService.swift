//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Combine
import CombineExt

protocol WeatherAPIServiceProtocol: AnyObject {
    func search(_ query: String) -> AnyPublisher<NetworkingServiceResponse<[Location]>, Error>
}

class WeatherAPIService: WeatherAPIServiceProtocol {
    private let networkingService: any NetworkingServiceProtocol
    
    private let apiKey = "12564ad7565e46e7b1e60542242111"
    
    init(networkingService: any NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func search(_ query: String) -> AnyPublisher<NetworkingServiceResponse<[Location]>, Error> {
        self.networkingService.publishers
            .fetch(
                from: URL(string: "https://api.weatherapi.com/v1/search.json")!,
                parameters: [
                    "key": self.apiKey,
                    "q": query
                ])
                .eraseToAnyPublisher()
    }
    
    func current(for location: Location) -> AnyPublisher<NetworkingServiceResponse<Data>, Error> {
        self.networkingService.publishers
            .fetch(
                from: URL(string: "https://api.weatherapi.com/v1/current.json")!,
                parameters: [
                    "key": self.apiKey,
                    "q": location.name
                ])
                .eraseToAnyPublisher()
    }
}
