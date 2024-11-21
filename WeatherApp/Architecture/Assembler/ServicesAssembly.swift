//
//  ServicesAssembly.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Swinject
class ServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Theme.self) { _ in
            Theme(colors: .appAppearance)
        }.inObjectScope(.container)
    }
}
