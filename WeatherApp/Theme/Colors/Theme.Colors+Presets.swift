//
//  Theme.Colors+Presets.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI

extension Theme.Colors {
    /// The default color palette. It supports both light and dark appearances.
    public static var `default`: Theme.Colors {
        Theme.Colors()
    }
    
    public static var appAppearance: Theme.Colors {
        Theme.Colors(
            background: .white,
            secondaryBackground: UIColor(hex: "#F2F2F2")!,
            label: UIColor(hex: "#2C2C2C")!,
            secondaryLabel: UIColor(hex: "#9A9A9A")!,
            tertiaryLabel: UIColor(hex: "#C4C4C4")!,
            textFieldBorder: UIColor(hex: "#E0E0E0")!,
            cardBackground: UIColor(hex: "#F2F2F2")!
        )
    }
}

