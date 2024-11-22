//
//  WeatherAppLandingViewModelTests.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import XCTest
@testable import WeatherApp

class WeatherAppLandingViewModelTestDelegate: WeatherAppLandingViewModel.Delegate {
    var didTapSearchTestClosure: ((_ source: WeatherAppLandingViewModel) -> Void)?
    func weatherAppLandingViewModelDidTapSearch(_ source: WeatherAppLandingViewModel) {
        guard let closure = self.didTapSearchTestClosure else {
            fatalError("Test closure not set")
        }
        closure(source)
    }
}

class WeatherAppLandingViewModelTest: XCTestCase {
    var mockLocalStorageService: MOCKLocalStorageService!
    var mockWeatherAPIService: MOCKWeatherAPIService!
    var delegate: WeatherAppLandingViewModelTestDelegate!
    var subject: WeatherAppLandingViewModel!
    
    override func setUp() {
        super.setUp()
        self.mockLocalStorageService = MOCKLocalStorageService()
        self.mockWeatherAPIService = MOCKWeatherAPIService()
        self.delegate = WeatherAppLandingViewModelTestDelegate()
        setupTestClosures()
        self.subject = WeatherAppLandingViewModel(
            localStorage: self.mockLocalStorageService,
            weatherAPIService: MOCKWeatherAPIService())
            .setup(delegate: self.delegate)
    }
    
    func setupTestClosures() {}
}

class WeatherAppLandingViewModel_WHEN_initialized_with_location_not_stored: WeatherAppLandingViewModelTest {
    var localStorageValueForDataKeyCallCount: Int = 0
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockLocalStorageService.valueForDataKeyTestClosure = { key in
            self.localStorageValueForDataKeyCallCount += 1
            return nil
        }
    }
    
    func test_THEN_localStorageValueForDataKey_is_called_once() {
        XCTAssertEqual(self.localStorageValueForDataKeyCallCount, 1)
    }
    
    func test_THEN_selectedWeatherViewModel_is_nil() {
        XCTAssertNil(self.subject.selectedWeatherViewModel)
    }
}

class WeatherAppLandingViewModel_WHEN_initialized_with_location_stored: WeatherAppLandingViewModelTest {
    var localStorageValueForDataKeyCallCount: Int = 0
    let expectedLocation = Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country")
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockLocalStorageService.valueForDataKeyTestClosure = { key in
            self.localStorageValueForDataKeyCallCount += 1
            return try? JSONEncoder().encode(self.expectedLocation)
        }
    }
    
    func test_THEN_localStorageValueForDataKey_is_called_once() {
        XCTAssertEqual(self.localStorageValueForDataKeyCallCount, 1)
    }
    
    func test_THEN_selectedWeatherViewModel_is_not_nil() {
        XCTAssertNotNil(self.subject.selectedWeatherViewModel)
    }
    
    func test_THEN_selectedWeatherViewModel_location_is_expected_location() {
        XCTAssertEqual(self.subject.selectedWeatherViewModel?.location, self.expectedLocation)
    }
}

class WeatherAppLandingViewModel_WHEN_onSearchTapped_is_called: WeatherAppLandingViewModelTest {
    var delegateDidTapSearchCallCount: Int = 0
    
    override func setUp() {
        super.setUp()
        self.subject.onSearchTapped()
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockLocalStorageService.valueForDataKeyTestClosure = { key in
            return nil
        }
        self.delegate.didTapSearchTestClosure = { source in
            self.delegateDidTapSearchCallCount += 1
        }
    }
    
    func test_THEN_delegate_didTapSearch_is_called_once() {
        XCTAssertEqual(self.delegateDidTapSearchCallCount, 1)
    }
}

class WeatherAppLandingViewModel_WHEN_selectCurrentWeatherViewModel_is_called: WeatherAppLandingViewModelTest {
    var localStorageValueForDataKeyCallCount: Int = 0
    var localStorageSetValueForDataKeyCallCount: Int = 0
    let expectedLocation: Location = Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country")
    var expectedCurrentWeatherViewModel: CurrentWeatherViewModel!
    
    override func setUp() {
        super.setUp()
        self.expectedCurrentWeatherViewModel = CurrentWeatherViewModel(
            location: self.expectedLocation,
            weatherAPIService: self.mockWeatherAPIService)
        self.subject.select(self.expectedCurrentWeatherViewModel)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockLocalStorageService.valueForDataKeyTestClosure = { key in
            self.localStorageValueForDataKeyCallCount += 1
            return nil
        }
        self.mockLocalStorageService.setValueForDataKeyTestClosure = { key, value in
            self.localStorageSetValueForDataKeyCallCount += 1
        }
    }
    
    func test_THEN_localStorageValueForDataKey_is_called_once() {
        XCTAssertEqual(self.localStorageValueForDataKeyCallCount, 1)
    }
    
    func test_THEN_selectedWeatherViewModel_is_expected() {
        XCTAssertEqual(self.subject.selectedWeatherViewModel, self.expectedCurrentWeatherViewModel)
    }
    
    func test_THEN_selectedWeatherViewModel_location_is_expected_location() {
        XCTAssertEqual(self.subject.selectedWeatherViewModel?.location, self.expectedLocation)
    }
    
    func test_THEN_localStorageSetValueForDataKey_is_called_once() {
        XCTAssertEqual(self.localStorageSetValueForDataKeyCallCount, 1)
    }
}
