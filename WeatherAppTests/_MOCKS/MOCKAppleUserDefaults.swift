//
//  MOCKAppleUserDefaults.swift
//  WeatherAppTests
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation
@testable import WeatherApp

class MOCKAppleUserDefaults: AppleUserDefaults {
    var boolForeKeyTestClosure: ((_ name: String) -> Bool)?
    func bool(forKey defaultName: String) -> Bool {
        guard let closure = self.boolForeKeyTestClosure else {
            fatalError("Test closure not set")
        }
        return closure(defaultName)
    }
    
    var dataForKeyTestClosure: ((_ name: String) -> Data?)?
    func data(forKey defaultName: String) -> Data? {
        guard let closure = self.dataForKeyTestClosure else {
            return nil
        }
        return closure(defaultName)
    }
    
    var objectForKeyTestClosure: ((_ name: String) -> Any?)?
    func object(forKey defaultName: String) -> Any? {
        guard let closure = self.objectForKeyTestClosure else {
            fatalError("Test closure not set")
        }
        return closure(defaultName)
    }
    
    var stringForKeyTestClosure: ((_ name: String) -> String?)?
    func string(forKey defaultName: String) -> String? {
        guard let closure = self.stringForKeyTestClosure else {
            fatalError("Test closure not set")
        }
        return closure(defaultName)
    }
    
    var setBoolForKeyTestClosure: ((_ value: Bool, _ name: String) -> Void)?
    func set(_ value: Bool, forKey defaultName: String) {
        guard let closure = self.setBoolForKeyTestClosure else {
            fatalError("Test closure not set")
        }
        closure(value, defaultName)
    }
    
    var setAnyForKeyTestClosure: ((_ value: Any?, _ name: String) -> Void)?
    func set(_ value: Any?, forKey defaultName: String) {
        guard let closure = self.setAnyForKeyTestClosure else {
            fatalError("Test closure not set")
        }
        closure(value, defaultName)
    }
    
    var removePersistentDomainTestClosure: ((_ domainName: String) -> Void)?
    func removePersistentDomain(forName domainName: String) {
        guard let closure = self.removePersistentDomainTestClosure else {
            fatalError("Test closure not set")
        }
        closure(domainName)
    }
}
