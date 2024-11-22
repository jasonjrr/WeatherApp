//
//  MOCKWeatherAPIService.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation
import Combine
@testable import WeatherApp

class MOCKWeatherAPIService: WeatherAPIServiceProtocol {
    var searchTestClosure: ((_ query: String) throws -> [Location])?
    func search(_ query: String) -> AnyPublisher<NetworkingServiceResponse<[Location]>, any Error> {
        guard let closure = self.searchTestClosure else {
            fatalError("Test closure not set")
        }
        do {
            let value = try closure(query)
            return Just(NetworkingServiceResponse(
                model: value, response: URLResponse()))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    var currentTestClosure: ((_ location: Location) throws -> CurrentWeather)?
    func current(for location: Location) -> AnyPublisher<NetworkingServiceResponse<CurrentWeather>, any Error> {
        guard let closure = self.currentTestClosure else {
            fatalError("Test closure not set")
        }
        do {
            let value = try closure(location)
            return Just(NetworkingServiceResponse(
                model: value, response: URLResponse()))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
