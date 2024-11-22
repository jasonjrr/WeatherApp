//
//  MOCKNetworkingService.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation
import Combine
@testable import WeatherApp

class MockNetworkingService<TestModel: Decodable>: NetworkingServiceProtocol {
    var imageURLCache: URLCache?
    
    var fetchFromURLCalled: Bool = false
    var fetchFromURLOutputResult: Result<TestModel, Error>?
    func fetch<Model>(from url: URL) -> AnyPublisher<NetworkingServiceResponse<Model>, any Error> where Model : Decodable {
        fetchFromURLCalled = true
        switch fetchFromURLOutputResult {
        case .success(let model):
            return Just(NetworkingServiceResponse(model: model as! Model, response: HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        case .none:
            fatalError(Errors.mockClosureNotImplemented.localizedDescription)
        }
    }
    
    func fetch<Model>(from url: URL, parameters: [String : String]?) -> AnyPublisher<NetworkingServiceResponse<Model>, any Error> where Model : Decodable {
        fatalError("Not implemented")
    }
}

extension MockNetworkingService {
    enum Errors: Error {
        case mockClosureNotImplemented
    }
}

struct IgnoredModel: Decodable {}

// MARK: Publishers
extension MockNetworkingService {
    public struct NetworkingServicePublishersProxy: NetworkingServicePublishersProxyProtocol {
        private let service: MockNetworkingService
        
        fileprivate init(service: MockNetworkingService) {
            self.service = service
        }
        
        public func fetch<Model>(from url: URL) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Decodable, Model: Encodable {
            self.service.fetch(from: url)
        }
    
        public func fetch<Model>(from url: URL, parameters: [String: String]?) -> AnyPublisher<NetworkingServiceResponse<Model>, Error> where Model: Decodable, Model: Encodable {
            self.service.fetch(from: url, parameters: parameters)
        }
        
        public func post<Input, Output>(_ input: Input, toURL url: URL) -> AnyPublisher<NetworkingServiceResponse<Output>, Error> where Input: Codable, Output: Codable {
            fatalError("Not implemented")
        }
    }
    
    public var publishers: some NetworkingServicePublishersProxyProtocol {
        NetworkingServicePublishersProxy(service: self)
    }
}

// MARK: Async
extension MockNetworkingService {
    public struct NetworkingServiceAsyncProxy: NetworkingServiceAsyncProxyProtocol {
        private let service: MockNetworkingService
        
        fileprivate init(service: MockNetworkingService) {
            self.service = service
        }
        
        public func fetch<Model>(
            from url: URL,
            parameters: [String: String]?
        ) async throws -> NetworkingServiceResponse<Model> where Model: Decodable, Model: Encodable {
            try await self.service.fetch(from: url).async()
        }
    }
    
    public var async: some NetworkingServiceAsyncProxyProtocol {
        NetworkingServiceAsyncProxy(service: self)
    }
}
