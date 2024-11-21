//
//  NetworkingServiceImageResponse.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import UIKit.UIImage

public struct NetworkingServiceImageResponse {
    /// The ``UIImage`` from a successful response
    public let image: UIImage
    /// The raw ``Data`` for the image returned from the response
    public let data: Data
    /// The original ``URLResponse`` object for reference
    public let response: URLResponse
    
    public init(image: UIImage, data: Data, response: URLResponse) {
        self.image = image
        self.data = data
        self.response = response
    }
}
