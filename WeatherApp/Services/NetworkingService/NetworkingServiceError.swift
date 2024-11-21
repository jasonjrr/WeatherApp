//
//  NetworkingServiceError.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation

/// Errors that occur while handling `NetworkService` responses
public enum NetworkingServiceError: LocalizedError {
    case malformedURL
    case failedToCreateImageFromData
}
