//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

struct CurrentWeather: Codable {
    let location: Location
    let weather: Weather?
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case weather = "current"
    }
}

struct Weather: Codable {
    let temperatureF: Double
    let feelsLikeF: Double
    let condition: Condition
    let humidity: Int
    let uvIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case temperatureF = "temp_f"
        case feelsLikeF = "feelslike_f"
        case condition
        case humidity
        case uvIndex = "uv"
    }
}

extension Weather {
    struct Condition: Codable {
        let text: String
        let iconURL: String
        let code: Int
        
        enum CodingKeys: String, CodingKey {
            case text
            case iconURL = "icon"
            case code
        }
    }
}
