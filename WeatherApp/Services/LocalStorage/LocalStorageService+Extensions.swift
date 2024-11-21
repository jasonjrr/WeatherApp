//
//  LocalStorageService+Extensions.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

extension LocalStorageServiceProtocol {
    func getLocation() -> Location? {
        guard let data: Data = value(for: .location) else {
            return nil
        }
        return try? JSONDecoder().decode(Location.self, from: data)
    }
    
    func setLocation(_ location: Location?) {
        if let location, let data = try? JSONEncoder().encode(location) {
            set(data, for: .location)
        } else {
            set(nil, for: .location)
        }
    }
}
