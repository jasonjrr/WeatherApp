//
//  AppRootCoordinatorViewModel.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Swinject

@Observable
class AppRootCoordinatorViewModel: ViewModel {
    @ObservationIgnored
    private let resolver: Resolver
    
    let weatherAppLandingViewModel: WeatherAppLandingViewModel
    
    init(resolver: Resolver) {
        self.resolver = resolver
        self.weatherAppLandingViewModel = resolver.resolve(WeatherAppLandingViewModel.self)!
        self.weatherAppLandingViewModel.setup(delegate: self)
    }
}

// MARK: WeatherAppLandingViewModel.Delegate
extension AppRootCoordinatorViewModel: WeatherAppLandingViewModel.Delegate {
    
}
