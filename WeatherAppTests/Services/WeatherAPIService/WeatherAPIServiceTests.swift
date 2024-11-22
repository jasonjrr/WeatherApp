//
//  WeatherAPIServiceTests.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import XCTest
@testable import WeatherApp

class WeatherAPIService_WHEN_search_is_called: XCTestCase {
    var mockNetworkingService: MOCKNetworkingService<[Location]>!
    var subject: WeatherAPIService!
    
    let expectedModel: [Location] = [Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country")]
    var actualModel: [Location]?
    
    override func setUp() async throws {
        try await super.setUp()
        self.mockNetworkingService = MOCKNetworkingService()
        self.mockNetworkingService.fetchFromURLWithParametersOutputResult = .success(self.expectedModel)
        self.subject = WeatherAPIService(networkingService: self.mockNetworkingService)
        
        self.actualModel = try await self.subject.search("test").async().model
    }
    
    func test_THEN_fetchFromURLWithParametersCalled_is_true() async throws {
        XCTAssertTrue(self.mockNetworkingService.fetchFromURLWithParametersCalled)
    }
    
    func test_THEN_actualModel_equals_expectedModel() async throws {
        XCTAssertEqual(self.actualModel, self.expectedModel)
    }
}

class WeatherAPIService_WHEN_current_is_called: XCTestCase {
    var mockNetworkingService: MOCKNetworkingService<CurrentWeather>!
    var subject: WeatherAPIService!
    
    let expectedModel: CurrentWeather = CurrentWeather(
        location: Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country"),
        weather: Weather(
            temperatureF: 1,
            feelsLikeF: 2,
            condition: Weather.Condition(
                text: "test.text",
                iconURL: "test.icon.url",
                code: 7),
            humidity: 3,
            uvIndex: 4)
    )
    var actualModel: CurrentWeather?
    
    override func setUp() async throws {
        try await super.setUp()
        self.mockNetworkingService = MOCKNetworkingService()
        self.mockNetworkingService.fetchFromURLWithParametersOutputResult = .success(self.expectedModel)
        self.subject = WeatherAPIService(networkingService: self.mockNetworkingService)
        
        self.actualModel = try await self.subject.current(for: Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country")).async().model
    }
    
    func test_THEN_fetchFromURLWithParametersCalled_is_true() async throws {
        XCTAssertTrue(self.mockNetworkingService.fetchFromURLWithParametersCalled)
    }
    
    func test_THEN_actualModel_equals_expectedModel() async throws {
        XCTAssertEqual(self.actualModel, self.expectedModel)
    }
}
