//
//  ViewModelAssembly.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocationSearchViewModel.self) { resolver in
            LocationSearchViewModel(
                weatherAPIService: resolver.resolve(WeatherAPIServiceProtocol.self)!)
        }.inObjectScope(.transient)
        
        container.register(WeatherAppLandingViewModel.self) { resolver in
            WeatherAppLandingViewModel(
                localStorage: resolver.resolve(LocalStorageServiceProtocol.self)!,
                weatherAPIService: resolver.resolve(WeatherAPIServiceProtocol.self)!)
        }.inObjectScope(.transient)
    }
}
