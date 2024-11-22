//
//  Location.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation

struct Location: Codable {
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

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.lat == rhs.lat 
        && lhs.lon == rhs.lon
        && lhs.name == rhs.name
        && lhs.region == rhs.region
        && lhs.country == rhs.country
    }
}
