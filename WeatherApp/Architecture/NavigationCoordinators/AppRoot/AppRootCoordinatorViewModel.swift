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
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}
