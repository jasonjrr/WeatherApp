//
//  UIColor+Color.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import SwiftUI

extension UIColor {
    /// - Returns: a ``Color`` View from this `UIColor`
    @inlinable
    public var color: Color { Color(uiColor: self) }
}
