//
//  WeatherAppLandingView.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI

struct WeatherAppLandingView: View {
    @Environment(Theme.self) private var theme
    @Bindable private var viewModel: WeatherAppLandingViewModel
    
    init(viewModel: WeatherAppLandingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}
