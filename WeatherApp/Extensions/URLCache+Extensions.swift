//
//  URLCache+Extensions.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

extension URLCache {
    static func setCacheSize() {
        URLCache.shared.memoryCapacity = 50_000_000 // ~50 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }
}
