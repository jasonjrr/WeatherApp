//
//  WeatherAppLandingViewModel.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation

@Observable
class WeatherAppLandingViewModel: ViewModel {
    private weak var delegate: WeatherAppLandingViewModel.Delegate?
    
    @discardableResult
    func setup(delegate: WeatherAppLandingViewModel.Delegate) -> Self {
        self.delegate = delegate
        return self
    }
}

extension WeatherAppLandingViewModel {
    protocol Delegate: AnyObject {
        
    }
}
