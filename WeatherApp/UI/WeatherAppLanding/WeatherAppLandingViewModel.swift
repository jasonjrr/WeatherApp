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
    private weak var delegate: Delegate?
    
    private(set) var selectedWeatherViewModel: CurrentWeatherViewModel?
    
    init() {}
    
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
    }
}

extension WeatherAppLandingViewModel {
    protocol Delegate: AnyObject {
        func weatherAppLandingViewModelDidTapSearch(_ source: WeatherAppLandingViewModel)
    }
}
