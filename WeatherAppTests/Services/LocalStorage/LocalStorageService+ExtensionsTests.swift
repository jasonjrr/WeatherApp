//
//  LocalStorageService+ExtensionsTests.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import XCTest
@testable import WeatherApp

class LocalStorageService_WHEN_getLocation_is_called: LocalStorageServiceTest {
    var dataForKeyCallCount: Int = 0
    var expectedLocation: Location = Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country")
    var actualLocation: Location?
    
    override func setUp() {
        super.setUp()
        self.actualLocation = self.subject.getLocation()
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.dataForKeyTestClosure = { key in
            self.dataForKeyCallCount += 1
            let data = try! JSONEncoder().encode(self.expectedLocation)
            return data
        }
    }
    
    func test_THEN_UserDefaults_dataForKey_is_called_once() {
        XCTAssertEqual(self.dataForKeyCallCount, 1)
    }
    
    func test_THEN_actualLocation_equals_expected() {
        XCTAssertEqual(self.actualLocation, self.expectedLocation)
    }
}

class LocalStorageService_WHEN_setLocation_is_called: LocalStorageServiceTest {
    var setDataForKeyCallCount: Int = 0
    var expectedLocation: Location = Location(lat: 1, lon: 2, name: "test.name", region: "test.region", country: "test.country")
    var actualLocation: Location?
    
    override func setUp() {
        super.setUp()
        self.subject.setLocation(self.expectedLocation)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.setAnyForKeyTestClosure = { value, key in
            self.setDataForKeyCallCount += 1
            if let data = value as? Data {
                self.actualLocation = try? JSONDecoder().decode(Location.self, from: data)
            } else {
                self.actualLocation = nil
            }
        }
    }
    
    func test_THEN_UserDefaults_setDataForKey_is_called_once() {
        XCTAssertEqual(self.setDataForKeyCallCount, 1)
    }
    
    func test_THEN_actualLocation_equals_expected() {
        XCTAssertEqual(self.actualLocation, self.expectedLocation)
    }
}
