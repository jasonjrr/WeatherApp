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
        VStack {
            SearchFieldView(title: "Search Location", query: .constant(.empty))
                .allowsHitTesting(false)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.viewModel.onSearchTapped()
                }
            Spacer()
            if let selectedWeatherViewModel = self.viewModel.selectedWeatherViewModel {
                ScrollView {
                    CurrentWeatherHighlightView(viewModel: selectedWeatherViewModel)
                        .padding(.top, 80.0)
                }
            } else {
                noLocationView()
            }
            Spacer()
        }
        .padding()
        .background(self.theme.colors.background.color)
    }
    
    private func noLocationView() -> some View {
        VStack {
            Text("No City Selected")
                .font(ofSize: 30.0)
                .foregroundStyle(self.theme.colors.label.color)
            Text("Please Search For A City")
                .font(ofSize: 15.0)
                .foregroundStyle(self.theme.colors.label.color)
                .padding()
        }
    }
}
