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
                        case .success(let locations):
                            ForEach(locations) { location in
                                Text(location.name)
                            }
                        case .failure(let error):
                            Text(error.localizedDescription)
                        }
                    } else {
                        Text("No Results")
                    }
                }
                .padding(.bottom, 56.0)
            }
            .scrollDismissesKeyboard(.interactively)
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
                .buttonStyle(.bordered)
                .padding()
            }
        }
        .background(self.theme.colors.background.color)
        .onAppear {
            self.isFocused = true
        }
    }
}
