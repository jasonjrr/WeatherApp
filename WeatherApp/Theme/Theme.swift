//
//  Theme.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI
import Combine

@Observable
public class Theme {
    public var colors: Theme.Colors
    public var fonts: Theme.Fonts
    
    public var constants: Constants = Constants()
    
    public init(
        colors: Theme.Colors = Colors(),
        fonts: Theme.Fonts = Fonts(),
        constants: Constants = Constants()
    ) {
        self.colors = colors
        self.fonts = fonts
        self.constants = constants
    }
}

// MARK: Constants
extension Theme {
    public struct Constants {
        public let disabledOpacity: Double
        
        public let minimumButtonSize: Double
        public let recommendedButtonSize: Double
        
        public let animationShortDistance: Double
        public let animationProgressSpinnerRevolution: Double
        
        public init(
            disabledOpacity: Double = 0.3,
            minimumButtonSize: Double = 44.0,
            recommendedButtonSize: Double = 48.0,
            animationShortDistance: Double = 0.18,
            animationProgressSpinnerRevolution: Double = 1.75
        ) {
            self.disabledOpacity = disabledOpacity
            self.minimumButtonSize = minimumButtonSize
            self.recommendedButtonSize = recommendedButtonSize
            self.animationShortDistance = animationShortDistance
            self.animationProgressSpinnerRevolution = animationProgressSpinnerRevolution
        }
    }
}
