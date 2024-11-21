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
    private weak var delegate: Delegate?
    
    private(set) var selectedLocation: Location?
    
    init() {}
    
    @discardableResult
    func setup(delegate: Delegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    func onSearchTapped() {
        self.delegate?.weatherAppLandingViewModelDidTapSearch(self)
    }
}

extension WeatherAppLandingViewModel {
    protocol Delegate: AnyObject {
        func weatherAppLandingViewModelDidTapSearch(_ source: WeatherAppLandingViewModel)
    }
}
