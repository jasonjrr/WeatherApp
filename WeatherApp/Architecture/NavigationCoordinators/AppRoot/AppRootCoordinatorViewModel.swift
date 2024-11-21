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
    private(set) var locationSearchViewModel: LocationSearchViewModel?
    
    init(resolver: Resolver) {
        self.resolver = resolver
        self.weatherAppLandingViewModel = resolver.resolve(WeatherAppLandingViewModel.self)!
        self.weatherAppLandingViewModel.setup(delegate: self)
    }
}

// MARK: WeatherAppLandingViewModel.Delegate
extension AppRootCoordinatorViewModel: WeatherAppLandingViewModel.Delegate {
    func weatherAppLandingViewModelDidTapSearch(_ viewModel: WeatherAppLandingViewModel) {
        self.locationSearchViewModel = resolver.resolve(LocationSearchViewModel.self)!
            .setup(delegate: self)
    }
}

// MARK: LocationSearchViewModel.Delegate
extension AppRootCoordinatorViewModel: LocationSearchViewModel.Delegate {
    func locationSearchViewModelDidCancel(_ source: LocationSearchViewModel) {
        self.locationSearchViewModel = nil
    }
}
