//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation
import Combine

@Observable
class CurrentWeatherViewModel: ViewModel {
    @ObservationIgnored
    private let weatherAPIService: any WeatherAPIServiceProtocol
    let location: Location
    private(set) var currentWeather: CurrentWeather?
    
    var currentTemperatureF: String {
        if let temperature = self.currentWeather?.weather.temperatureF {
            return "\(Int(temperature))"
        } else {
            return " "
        }
    }
    
    var conditionIconURL: URL? {
        if let iconURL = self.currentWeather?.weather.condition.iconURL,
           let url = URL(string: "https:" + iconURL) {
            return url
        } else {
            return nil
        }
    }
    
    var humidity: String {
        if let humidity = self.currentWeather?.weather.humidity {
            return "\(humidity)%"
        } else {
            return " "
        }
    }
    
    var uvIndex: String {
        if let uvIndex = self.currentWeather?.weather.uvIndex {
            return "\(uvIndex)"
        } else {
            return " "
        }
    }
    
    var feelsLikeTemperatureF: String {
        if let feelsLike = self.currentWeather?.weather.feelsLikeF {
            return "\(Int(feelsLike))º"
        } else {
            return " "
        }
    }
    
    init(location: Location, weatherAPIService: any WeatherAPIServiceProtocol) {
        self.location = location
        self.weatherAPIService = weatherAPIService
    }
    
    func fetchCurrentWeather() {
        Task {
            self.currentWeather = try? await self.weatherAPIService
                .current(for: self.location)
                .async()
                .model
        }
    }
}
