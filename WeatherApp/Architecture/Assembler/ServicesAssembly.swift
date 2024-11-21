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
        container.register(LocalStorageServiceProtocol.self) { _ in
            LocalStorageService(appleUserDefault: UserDefaults.standard)
        }.inObjectScope(.container)
        
        container.register((any NetworkingServiceProtocol).self) { _ in
            NetworkingService()
        }.inObjectScope(.container)
        
        container.register(Theme.self) { _ in
            Theme(colors: .appAppearance)
        }.inObjectScope(.container)
        
        container.register(WeatherAPIServiceProtocol.self) { resolver in
            WeatherAPIService(
                networkingService: resolver.resolve((any NetworkingServiceProtocol).self)!)
        }.inObjectScope(.container)
    }
}
