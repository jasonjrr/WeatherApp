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
        if let location = self.localStorage.getLocation() {
            self.selectedWeatherViewModel = CurrentWeatherViewModel(
                location: location,
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
        self.localStorage.setLocation(currentWeatherViewModel.location)
    }
}

extension WeatherAppLandingViewModel {
    protocol Delegate: AnyObject {
        func weatherAppLandingViewModelDidTapSearch(_ source: WeatherAppLandingViewModel)
    }
}
