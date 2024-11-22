//
//  LocationSearchView.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import SwiftUI

struct LocationSearchView: View {
    @Environment(Theme.self) private var theme
    @Bindable private var viewModel: LocationSearchViewModel
    
    @FocusState private var isFocused
    
    init(viewModel: LocationSearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            SearchFieldView(title: "Search Location", query: self.$viewModel.query)
                .focused(self.$isFocused)
                .padding()
            ScrollView {
                LazyVStack {
                    if let searchResult = self.viewModel.searchResult {
                        switch searchResult {
                        case .success(let currentWeatherViewModels):
                            SuccessStackView(currentWeatherViewModels: currentWeatherViewModels) {
                                self.viewModel.select($0)
                            }
                        case .failure(let error):
                            Text(error.localizedDescription)
                        }
                    } else {
                        EmptyView()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 80.0)
            }
            .scrollDismissesKeyboard(.interactively)
            .refreshable {
                self.viewModel.refresh()
            }
            .overlay(alignment: .bottom) {
                Button {
                    self.isFocused = false
                    self.viewModel.cancel()
                } label: {
                    Text("Cancel")
                        .frame(
                            maxWidth: .infinity,
                            minHeight: self.theme.constants.minimumButtonSize,
                            idealHeight: self.theme.constants.minimumButtonSize)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .background(self.theme.colors.background.color)
        .onAppear {
            self.isFocused = true
        }
        .alert(
            Text(self.viewModel.alert?.title ?? .empty),
            isPresented: self.$viewModel.showAlert,
            presenting: self.viewModel.alert) { alert in
                ForEach(alert.actions) { action in
                    Button(action.label ?? .empty, role: action.role) {
                        action.handler?()
                    }
                }
            } message: { action in
                Text(action.message ?? .empty)
            }
    }
}

extension LocationSearchView {
    struct SuccessStackView: View {
        let currentWeatherViewModels: [CurrentWeatherViewModel]
        private let select: (CurrentWeatherViewModel) -> Void
        
        init(currentWeatherViewModels: [CurrentWeatherViewModel], select: @escaping (CurrentWeatherViewModel) -> Void) {
            self.currentWeatherViewModels = currentWeatherViewModels
            self.select = select
        }
        
        var body: some View {
            LazyVStack {
                ForEach(currentWeatherViewModels) { currentWeatherViewModel in
                    weatherLocationButton(currentWeatherViewModel)
                }
            }
            .transition(.opacity)
            .animation(.smooth, value: self.currentWeatherViewModels)
        }
        
        private func weatherLocationButton(_ currentWeatherViewModel: CurrentWeatherViewModel) -> some View {
            Button {
                select(currentWeatherViewModel)
            } label: {
                CurrentWeatherSearchCardView(viewModel: currentWeatherViewModel)
                    .task {
                        currentWeatherViewModel.fetchCurrentWeather()
                    }
            }
            .buttonStyle(.plain)
        }
    }
}
