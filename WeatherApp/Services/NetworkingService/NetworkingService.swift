//
//  NetworkingService.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Combine
import UIKit.UIImage

/// Service definition for centralized networking control
public protocol NetworkingServiceProtocol: AnyObject {
    associatedtype PublishersProxy : NetworkingServicePublishersProxyProtocol
    associatedtype AsyncProxy : NetworkingServiceAsyncProxyProtocol
    
    var imageURLCache: URLCache? { get set }
    
    /// `PublishersProxy` adhering to `NetworkingServicePublishersProxyProtocol`
    /// - Returns: A concrete implementation of `NetworkingServicePublishersProxyProtocol`
    var publishers: Self.PublishersProxy { get }
    
    /// `AsyncProxy` adhering to `NetworkingServiceAsyncProxyProtocol`
    /// - Returns: A concrete implementation of `NetworkingServiceAsyncProxyProtocol`
    var async: Self.AsyncProxy { get }
}

/// Proxy definition for `Publisher`-based networking
public protocol NetworkingServicePublishersProxyProtocol {
    /// Fetches data from the specified `URL` and decodes it into the provided `Model` type.
    ///
    /// - Parameters:
    ///   - url: The `URL` from which to fetch data.
    /// - Returns: A publisher that delivers a `NetworkingServiceResponse` or an `Error` upon completion.
    func fetch<Model>(from url: URL) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Codable
    
    /// Fetches data from the specified `URL` with optional parameters and decodes it into the provided `Model` type.
    ///
    /// - Parameters:
    ///   - url: The `URL` from which to fetch data.
    ///   - parameters: Optional parameters for the request.
    /// - Returns: A publisher that delivers a `NetworkingServiceResponse` or an `Error` upon completion.
    func fetch<Model>(from url: URL, parameters: [String: String]?) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Codable
}

/// Proxy definition for async-based networking
/// A protocol for handling asynchronous networking operations using Swift concurrency.
public protocol NetworkingServiceAsyncProxyProtocol {
    /// Asynchronously fetches data from the specified `URL` with optional parameters and decodes it into the provided `Model` type.
    ///
    /// - Parameters:
    ///   - url: The `URL` from which to fetch data.
    ///   - parameters: Optional parameters for the request.
    /// - Returns: A `NetworkingServiceResponse` containing the decoded `Model` data.
    func fetch<Model>(from url: URL, parameters: [String: String]?) async throws -> NetworkingServiceResponse<Model> where Model: Codable
}

/// `NetworkingService` implementation for centralizing, and configuring your requests and caching
public final class NetworkingService: NetworkingServiceProtocol {
    private static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    private static var jsonDecoder: JSONDecoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Self.dateFormat

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }
    private static var jsonEncoder: JSONEncoder {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Self.dateFormat
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        return encoder
    }
    
    public let configuration: URLSessionConfiguration
    public var imageURLCache: URLCache?
    
    public init(configuration: URLSessionConfiguration = .default, imageURLCache: URLCache? = nil) {
        self.configuration = configuration
        self.imageURLCache = imageURLCache
    }
    
    private func fetch<Model>(
        from url: URL,
        parameters: [String: String]? = nil
    ) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Codable {
        let finalURL: URL
        if let parameters = parameters {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                return Fail(error: NetworkingServiceError.malformedURL).eraseToAnyPublisher()
            }
            urlComponents.queryItems = parameters.map { (key: String, value: String) in
                URLQueryItem(name: key, value: value)
            }
            guard let url = urlComponents.url else {
                return Fail(error: NetworkingServiceError.malformedURL).eraseToAnyPublisher()
            }
            finalURL = url
        } else {
            finalURL = url
        }
        
        let urlRequest = URLRequest(url: finalURL)
        
        return URLSession(configuration: self.configuration)
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) in
                let model = try Self.jsonDecoder.decode(Model.self, from: data)
                return NetworkingServiceResponse(model: model, response: response)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: Publishers
extension NetworkingService {
    public struct NetworkingServicePublishersProxy: NetworkingServicePublishersProxyProtocol {
        private let service: NetworkingService
        
        fileprivate init(service: NetworkingService) {
            self.service = service
        }
        
        public func fetch<Model>(from url: URL) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Decodable, Model: Encodable {
            self.service.fetch(from: url)
        }
        
        public func fetch<Model>(from url: URL, parameters: [String: String]?) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Decodable, Model: Encodable {
            self.service.fetch(from: url, parameters: parameters)
        }
    }
    
    public var publishers: some NetworkingServicePublishersProxyProtocol {
        NetworkingServicePublishersProxy(service: self)
    }
}

// MARK: Async
extension NetworkingService {
    public struct NetworkingServiceAsyncProxy: NetworkingServiceAsyncProxyProtocol {
        private let service: NetworkingService
        
        fileprivate init(service: NetworkingService) {
            self.service = service
        }
        
        public func fetch<Model>(
            from url: URL,
            parameters: [String: String]?
        ) async throws -> NetworkingServiceResponse<Model> where Model: Decodable, Model: Encodable {
            try await self.service.fetch(from: url, parameters: parameters).async()
        }
    }
    
    public var async: some NetworkingServiceAsyncProxyProtocol {
        NetworkingServiceAsyncProxy(service: self)
    }
}
