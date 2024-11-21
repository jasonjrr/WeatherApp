//
//  Location.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation

struct Location: Identifiable, Codable {
    let id: UUID = UUID()
    let lat: Double
    let lon: Double
    let name: String
    let region: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case name
        case region
        case country
    }
}
