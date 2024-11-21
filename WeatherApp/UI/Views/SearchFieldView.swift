//
//  SearchFieldView.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI

struct SearchFieldView: View {
    @Environment(Theme.self) private var theme
    @ScaledMetric private var iconSize: CGFloat = 17.5
    
    private let title: String
    @Binding private var query: String
    
    @FocusState private var isFocused
    
    init(title: String, query: Binding<String>) {
        self.title = title
        self._query = query
    }
    
    var body: some View {
        HStack {
            TextField(String.empty, text: self.$query)
                .focused(self.$isFocused)
                .foregroundStyle(self.theme.colors.label.color)
                .overlay(alignment: .leading) {
                    if self.query.isEmpty {
                        Text(self.title)
                            .foregroundStyle(self.theme.colors.tertiaryLabel.color)
                    }
                }
            Image(.search)
                .resizable()
                .scaledToFit()
                .frame(width: self.iconSize, height: self.iconSize)
                .foregroundStyle(self.theme.colors.secondaryLabel.color)
        }
        .font(ofSize: 15.0)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16.0, style: .circular)
                .fill(self.theme.colors.cardBackground.color)
                .onTapGesture {
                    self.isFocused = true
                }
        }
        .compositingGroup()
    }
}

#Preview {
    ScrollView {
        VStack {
            SearchFieldView(title: "Search Location", query: .constant(""))
            
            SearchFieldView(title: "Search Location", query: .constant("Mumbai"))
        }
        .padding()
    }
    .environment(Theme(colors: .appAppearance))
}
