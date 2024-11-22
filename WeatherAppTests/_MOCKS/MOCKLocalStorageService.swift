//
//  MOCKLocalStorageService.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation
@testable import WeatherApp

class MOCKLocalStorageService: LocalStorageServiceProtocol {
    var deleteAllValuesTestClosure: (() -> Void)?
    func deleteAllValues() {
        guard let closure = self.deleteAllValuesTestClosure else {
            fatalError("Test closure not set")
        }
        closure()
    }
    
    var valueForBoolKeyTestClosure: ((_ key: WeatherApp.LocalStorageBoolKey) -> Bool)?
    func value(for key: WeatherApp.LocalStorageBoolKey) -> Bool {
        guard let closure = self.valueForBoolKeyTestClosure else {
            fatalError("Test closure not set")
        }
        return closure(key)
    }
    
    var setValueForBoolKeyTestClosure: ((_ value: Bool, _ key: WeatherApp.LocalStorageBoolKey) -> Void)?
    func set(_ value: Bool, for key: WeatherApp.LocalStorageBoolKey) {
        guard let closure = self.setValueForBoolKeyTestClosure else {
            fatalError("Test closure not set")
        }
        closure(value, key)
    }
    
    var valueForDataKeyTestClosure: ((_ key: WeatherApp.LocalStorageDataKey) -> Data?)?
    func value(for key: WeatherApp.LocalStorageDataKey) -> Data? {
        guard let closure = self.valueForDataKeyTestClosure else {   
            fatalError("Test closure not set")
        }
        return closure(key)
    }
    
    var setValueForDataKeyTestClosure: ((_ value: Data?, _ key: WeatherApp.LocalStorageDataKey) -> Void)?
    func set(_ value: Data?, for key: WeatherApp.LocalStorageDataKey) {
        guard let closure = self.setValueForDataKeyTestClosure else {
            fatalError("Test closure not set")
        }
        closure(value, key)
    }
    
    var valueForStringKeyTestClosure: ((_ key: WeatherApp.LocalStorageStringKey) -> String?)?
    func value(for key: WeatherApp.LocalStorageStringKey) -> String? {
        guard let closure = self.valueForStringKeyTestClosure else {
            fatalError("Test closure not set")
        }
        return closure(key)
    }
    
    var setValueForStringKeyTestClosure: ((_ value: String?, _ key: WeatherApp.LocalStorageStringKey) -> Void)?
    func set(_ value: String?, for key: WeatherApp.LocalStorageStringKey) {
        guard let closure = self.setValueForStringKeyTestClosure else {
            fatalError("Test closure not set")
        }
        closure(value, key)
    }
}
