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

extension CurrentWeather: Equatable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        lhs.location == rhs.location
        && lhs.weather == rhs.weather
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

extension Weather: Equatable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.temperatureF == rhs.temperatureF
        && lhs.feelsLikeF == rhs.feelsLikeF
        && lhs.condition == rhs.condition
        && lhs.humidity == rhs.humidity
        && lhs.uvIndex == rhs.uvIndex
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

extension Weather.Condition: Equatable {
    static func == (lhs: Weather.Condition, rhs: Weather.Condition) -> Bool {
        lhs.text == rhs.text
        && lhs.iconURL == rhs.iconURL
        && lhs.code == rhs.code
    }
}
