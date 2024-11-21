//
//  WeatherAppLandingViewModel.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Combine

@Observable
class WeatherAppLandingViewModel: ViewModel {
    @ObservationIgnored
    private let localStorage: LocalStorageServiceProtocol
    
    @ObservationIgnored
    private weak var delegate: Delegate?
    
    private(set) var selectedWeatherViewModel: CurrentWeatherViewModel?
    
    init(localStorage: LocalStorageServiceProtocol, weatherAPIService: any WeatherAPIServiceProtocol) {
        self.localStorage = localStorage
        if let currentWeather = self.localStorage.getWeather() {
            self.selectedWeatherViewModel = CurrentWeatherViewModel(
                location: currentWeather.location,
                currentWeather: currentWeather,
                weatherAPIService: weatherAPIService)
        }
    }
    
    @discardableResult
    func setup(delegate: Delegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    func onSearchTapped() {
        self.delegate?.weatherAppLandingViewModelDidTapSearch(self)
    }
    
    func select(_ currentWeatherViewModel: CurrentWeatherViewModel) {
        self.selectedWeatherViewModel = currentWeatherViewModel
        if let currentWeather = currentWeatherViewModel.currentWeather {
            self.localStorage.setWeather(currentWeather)
        } else {
            self.localStorage.setWeather(CurrentWeather(location: currentWeatherViewModel.location, weather: nil))
        }
    }
}

extension WeatherAppLandingViewModel {
    protocol Delegate: AnyObject {
        func weatherAppLandingViewModelDidTapSearch(_ source: WeatherAppLandingViewModel)
    }
}
