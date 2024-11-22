//
//  LocalStorageServiceTests.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import XCTest
@testable import WeatherApp

class LocalStorageServiceTest: XCTestCase {
    var mockUserDefaults: MOCKAppleUserDefaults!
    var subject: LocalStorageService!
    
    override func setUp() {
        super.setUp()
        self.mockUserDefaults = MOCKAppleUserDefaults()
        setupTestClosures()
        self.subject = LocalStorageService(appleUserDefault: self.mockUserDefaults)
    }
    
    func setupTestClosures() {}
}

class LocalStorageService_WHEN_deleteAllValues_is_called: LocalStorageServiceTest {
    var removePersistentDomainCallCount: Int = 0
    let expectedDomainName = "com.jasonjrr.WeatherApp"
    var actualDomainName: String?
    
    override func setUp() {
        super.setUp()
        self.subject.deleteAllValues()
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.removePersistentDomainTestClosure = { domainName in
            self.removePersistentDomainCallCount += 1
            self.actualDomainName = domainName
        }
    }
    
    func test_THEN_UserDefaults_removePersistentDomain_is_called_once() {
        XCTAssertEqual(self.removePersistentDomainCallCount, 1)
    }
    
    func test_THEN_actual_domainName_equal_expected() {
        XCTAssertEqual(self.actualDomainName, self.expectedDomainName)
    }
}

class LocalStorageService_WHEN_valueForBoolKey_is_called: LocalStorageServiceTest {
    var boolForeKeyCallCount: Int = 0
    let expectedKey: LocalStorageBoolKey = .placeholderBool
    var actualKey: String?
    let expectedValue: Bool = true
    var actualValue: Bool?
    
    override func setUp() {
        super.setUp()
        self.actualValue = self.subject.value(for: self.expectedKey)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.boolForeKeyTestClosure = { key in
            self.boolForeKeyCallCount += 1
            self.actualKey = key
            return self.expectedValue
        }
    }
    
    func test_THEN_UserDefaults_boolForKey_is_called_once() {
        XCTAssertEqual(self.boolForeKeyCallCount, 1)
    }
    
    func test_THEN_actual_key_equal_expected() {
        XCTAssertEqual(self.actualKey, self.expectedKey.key)
    }
    
    func test_THEN_actual_value_equal_expected() {
        XCTAssertEqual(self.actualValue, self.expectedValue)
    }
}

class LocalStorageService_WHEN_valueForDataKey_is_called: LocalStorageServiceTest {
    var dataForKeyCallCount: Int = 0
    let expectedKey: LocalStorageDataKey = .location
    var actualKey: String?
    let expectedValue: Data = Data()
    var actualValue: Data?
    
    override func setUp() {
        super.setUp()
        self.actualValue = self.subject.value(for: self.expectedKey)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.dataForKeyTestClosure = { key in
            self.dataForKeyCallCount += 1
            self.actualKey = key
            return self.expectedValue
        }
    }
    
    func test_THEN_UserDefaults_dataForKey_is_called_once() {
        XCTAssertEqual(self.dataForKeyCallCount, 1)
    }
    
    func test_THEN_actual_key_equal_expected() {
        XCTAssertEqual(self.actualKey, self.expectedKey.key)
    }
    
    func test_THEN_actual_value_equal_expected() {
        XCTAssertEqual(self.actualValue, self.expectedValue)
    }
}

class LocalStorageService_WHEN_valueForStringKey_is_called: LocalStorageServiceTest {
    var stringForKeyCallCount: Int = 0
    let expectedKey: LocalStorageStringKey = .placeholderString
    var actualKey: String?
    let expectedValue: String = "test"
    var actualValue: String?
    
    override func setUp() {
        super.setUp()
        self.actualValue = self.subject.value(for: self.expectedKey)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.stringForKeyTestClosure = { key in
            self.stringForKeyCallCount += 1
            self.actualKey = key
            return self.expectedValue
        }
    }
    
    func test_THEN_UserDefaults_stringForKey_is_called_once() {
        XCTAssertEqual(self.stringForKeyCallCount, 1)
    }
    
    func test_THEN_actual_key_equal_expected() {
        XCTAssertEqual(self.actualKey, self.expectedKey.key)
    }
    
    func test_THEN_actual_value_equal_expected() {
        XCTAssertEqual(self.actualValue, self.expectedValue)
    }
}

class LocalStorageService_WHEN_setValueForBoolKeyIsCalled: LocalStorageServiceTest {
    var setBoolForKeyCallCount: Int = 0
    var expectedValue: Bool = true
    var actualValue: Bool?
    var expectedKey: LocalStorageBoolKey = .placeholderBool
    var actualKey: String?
    
    override func setUp() {
        super.setUp()
        self.subject.set(self.expectedValue, for: self.expectedKey)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.setBoolForKeyTestClosure = { value, key in
            self.setBoolForKeyCallCount += 1
            self.actualValue = value
            self.actualKey = key
        }
    }
    
    func test_THEN_UserDefaults_setBoolForKey_is_called_once() {
        XCTAssertEqual(self.setBoolForKeyCallCount, 1)
    }
    
    func test_THEN_actual_value_equal_expected() {
        XCTAssertEqual(self.actualValue, self.expectedValue)
    }
    
    func test_THEN_actual_key_equal_expected() {
        XCTAssertEqual(self.actualKey, self.expectedKey.key)
    }
}

class LocalStorageService_WHEN_setValueForDataKeyIsCalled: LocalStorageServiceTest {
    var setDataForKeyCallCount: Int = 0
    var expectedValue: Data = Data()
    var actualValue: Data?
    var expectedKey: LocalStorageDataKey = .location
    var actualKey: String?
    
    override func setUp() {
        super.setUp()
        self.subject.set(self.expectedValue, for: self.expectedKey)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.setAnyForKeyTestClosure = { value, key in
            self.setDataForKeyCallCount += 1
            self.actualValue = value as? Data
            self.actualKey = key
        }
    }
    
    func test_THEN_UserDefaults_setDataForKey_is_called_once() {
        XCTAssertEqual(self.setDataForKeyCallCount, 1)
    }
    
    func test_THEN_actual_value_equal_expected() {
        XCTAssertEqual(self.actualValue, self.expectedValue)
    }
    
    func test_THEN_actual_key_equal_expected() {
        XCTAssertEqual(self.actualKey, self.expectedKey.key)
    }
}

class LocalStorageService_WHEN_setValueForStringKeyIsCalled: LocalStorageServiceTest {
    var setStringForKeyCallCount: Int = 0
    var expectedValue: String = "test"
    var actualValue: String?
    var expectedKey: LocalStorageStringKey = .placeholderString
    var actualKey: String?
    
    override func setUp() {
        super.setUp()
        self.subject.set(self.expectedValue, for: self.expectedKey)
    }
    
    override func setupTestClosures() {
        super.setupTestClosures()
        self.mockUserDefaults.setAnyForKeyTestClosure = { value, key in
            self.setStringForKeyCallCount += 1
            self.actualValue = value as? String
            self.actualKey = key
        }
    }
    
    func test_THEN_UserDefaults_setStringForKey_is_called_once() {
        XCTAssertEqual(self.setStringForKeyCallCount, 1)
    }
    
    func test_THEN_actual_value_equal_expected() {
        XCTAssertEqual(self.actualValue, self.expectedValue)
    }
    
    func test_THEN_actual_key_equal_expected() {
        XCTAssertEqual(self.actualKey, self.expectedKey.key)
    }
}
