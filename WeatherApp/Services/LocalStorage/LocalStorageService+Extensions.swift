//
//  LocalStorageService+Extensions.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

extension LocalStorageServiceProtocol {
    func getWeather() -> CurrentWeather? {
        guard let data: Data = value(for: .weather) else {
            return nil
        }
        return try? JSONDecoder().decode(CurrentWeather.self, from: data)
    }
    
    func setWeather(_ currentWeather: CurrentWeather?) {
        if let currentWeather, let data = try? JSONEncoder().encode(currentWeather) {
            set(data, for: .weather)
        } else {
            set(nil, for: .weather)
        }
    }
}
