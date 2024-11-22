//
//  CurrentWeatherHighlightView.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import SwiftUI

struct CurrentWeatherHighlightView: View {
    @Environment(Theme.self) private var theme
    @Bindable private var viewModel: CurrentWeatherViewModel
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            AsyncImage(url: self.viewModel.conditionIconURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 124.0, height: 124.0)
            } placeholder: {
                ProgressView()
            }
            
            HStack {
                Text(self.viewModel.location.name)
                    .font(ofSize: 30.0, weight: .bold)
                Image(.location)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 21.0, height: 21.0)
            }
            
            HStack(alignment: .top) {
                Text(self.viewModel.currentTemperatureF)
                    .font(ofSize: 70.0, weight: .semibold)
                Text("º")
                    .font(ofSize: 24.0, weight: .semibold)
                    .padding(.top, 8.0)
            }
            
            HStack {
                cardItem("Humidity", value: self.viewModel.humidity)
                Spacer()
                cardItem("UV", value: self.viewModel.uvIndex)
                Spacer()
                cardItem("Feels Like", value: self.viewModel.feelsLikeTemperatureF)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(self.theme.colors.cardBackground.color)
            }
            .padding(.top, 16.0)
            .padding(.horizontal, 40.0)
        }
        .foregroundStyle(self.theme.colors.label.color)
    }
    
    private func cardItem(_ title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(ofSize: 12.0)
                .foregroundStyle(self.theme.colors.tertiaryLabel.color)
            Text(value)
                .font(ofSize: 15.0)
                .foregroundStyle(self.theme.colors.secondaryLabel.color)
        }
    }
}
