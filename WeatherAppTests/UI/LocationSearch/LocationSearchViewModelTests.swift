//
//  LocationSearchViewModelTests.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import XCTest
@testable import WeatherApp

class LocationSearchViewModelTestDelegate: LocationSearchViewModel.Delegate {
    var didSelectCurrentWeatherViewModelTestClosure: ((_ source: LocationSearchViewModel, _ currentWeatherViewModel: CurrentWeatherViewModel) -> Void)?
    func locationSearchViewModel(_ source: LocationSearchViewModel, didSelect currentWeatherViewModel: CurrentWeatherViewModel) {
        guard let closure = self.didSelectCurrentWeatherViewModelTestClosure else {
            fatalError("Test closure not set")
        }
        closure(source, currentWeatherViewModel)
    }
    
    var didCancelTestClosure: ((_ source: LocationSearchViewModel) -> Void)?
    func locationSearchViewModelDidCancel(_ source: LocationSearchViewModel) {
        guard let closure = self.didCancelTestClosure else {
            fatalError("Test closure not set")
        }
        closure(source)
    }
}

class LocationSearchViewModelTest: XCTestCase {
    var mockWeatherAPIService: MOCKWeatherAPIService!
    var delegate: LocationSearchViewModelTestDelegate!
    var subject: LocationSearchViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockWeatherAPIService = MOCKWeatherAPIService()
        self.delegate = LocationSearchViewModelTestDelegate()
        setupTestClosures()
        self.subject = LocationSearchViewModel(weatherAPIService: self.mockWeatherAPIService)
            .setup(delegate: self.delegate)
    }
    
    func setupTestClosures() {}
}

class LocationSearchViewModel_WHEN_initialized: LocationSearchViewModelTest {
    func test_THEN_query_is_empty() {
        XCTAssertEqual(self.subject.query, .empty)
    }
    
    func test_THEN_searchResult_is_nil() {
        XCTAssertNil(self.subject.searchResult)
    }
    
    func test_THEN_alert_is_nil() {
        XCTAssertNil(self.subject.alert)
    }
    
    func test_THEN_showAlert_is_false() {
        XCTAssertFalse(self.subject.showAlert)
    }
}

class LocationSearchViewMode_WHEN_selectCurrentWeatherViewModel_is_called: LocationSearchViewModelTest {
    var didSelectCurrentWeatherViewModelCallCount: Int = 0
    var expectedCurrentWeatherViewModel: CurrentWeatherViewModel!
    var actualCurrentWeatherViewModel: CurrentWeatherViewModel?
    
    override func setUp() {
        super.setUp()
        self.expectedCurrentWeatherViewModel = CurrentWeatherViewModel(
            location: Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country"),
            weatherAPIService: super.mockWeatherAPIService)
        self.subject.select(self.expectedCurrentWeatherViewModel)
    }
    
    override func setupTestClosures() {
        self.delegate.didSelectCurrentWeatherViewModelTestClosure = { source, currentWeatherViewModel in
            self.didSelectCurrentWeatherViewModelCallCount += 1
            self.actualCurrentWeatherViewModel = currentWeatherViewModel
        }
    }
    
    func test_THEN_didSelectCurrentWeatherViewModel_is_called_once() {
        XCTAssertEqual(self.didSelectCurrentWeatherViewModelCallCount, 1)
    }
    
    func test_THEN_didSelectCurrentWeatherViewModel_is_called_with_expected_currentWeatherViewModel() {
        XCTAssertEqual(self.actualCurrentWeatherViewModel, self.expectedCurrentWeatherViewModel)
    }
}

class LocationSearchViewModel_WHEN_cancel_is_called: LocationSearchViewModelTest {
    var didCancelCallCount: Int = 0
    
    override func setUp() {
        super.setUp()
        self.subject.cancel()
    }
    
    override func setupTestClosures() {
        self.delegate.didCancelTestClosure = { source in
            self.didCancelCallCount += 1
        }
    }
    
    func test_THEN_didCancel_is_called_once() {
        XCTAssertEqual(self.didCancelCallCount, 1)
    }
}
