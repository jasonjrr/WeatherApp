//
//  NavigationCoordinatorAssembly.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Swinject

class NavigationCoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppRootCoordinatorViewModel.self) { resolver in
            AppRootCoordinatorViewModel(resolver: resolver)
        }.inObjectScope(.container)
    }
}
