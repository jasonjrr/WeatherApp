//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI

fileprivate let appAssembler = AppAssembler()

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            AppRootCoordinatorView(
                coordinator: appAssembler.resolver.resolve(AppRootCoordinatorViewModel.self)!)
            .environment(appAssembler.resolver.resolve(Theme.self)!)
        }
    }
}
