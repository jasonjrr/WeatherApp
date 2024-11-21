//
//  CurrentWeatherSearchCardView.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import SwiftUI

struct CurrentWeatherSearchCardView: View {
    @Environment(Theme.self) private var theme
    @Bindable private var viewModel: CurrentWeatherViewModel
    
    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0.0) {
                Text(self.viewModel.location.name)
                    .font(ofSize: 20.0, weight: .bold)
                HStack(alignment: .top) {
                    Text("º")
                        .padding(.top, 12.0)
                    Text(self.viewModel.currentTemperatureF)
                        .font(ofSize: 60.0, weight: .semibold)
                }
            }
            .foregroundStyle(self.theme.colors.label.color)
            
            Spacer()
            
            AsyncImage(url: self.viewModel.conditionIconURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70.0, height: 70.0)
            } placeholder: {
                ProgressView()
            }
        }
        .padding(.horizontal)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(self.theme.colors.cardBackground.color)
        }
    }
}
