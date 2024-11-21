//
//  AppRootCoordinatorView.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI

struct AppRootCoordinatorView: View {
    @Bindable private var coordinator: AppRootCoordinatorViewModel
    
    init(coordinator: AppRootCoordinatorViewModel) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        WeatherAppLandingView(viewModel: self.coordinator.weatherAppLandingViewModel)
    }
}
