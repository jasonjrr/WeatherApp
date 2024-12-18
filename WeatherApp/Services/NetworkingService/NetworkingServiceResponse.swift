//
//  NetworkingServiceResponse.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation

public struct NetworkingServiceResponse<Model> where Model: Codable {
    /// The deserialized `Model` from the response
    public let model: Model
    /// The original ``URLResponse`` object for reference
    public let response: URLResponse
    
    public init(model: Model, response: URLResponse) {
        self.model = model
        self.response = response
    }
}
