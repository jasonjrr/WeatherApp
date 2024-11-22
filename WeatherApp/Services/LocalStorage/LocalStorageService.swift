//
//  LocalStorageService.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

protocol LocalStorageServiceProtocol: AnyObject {
    func deleteAllValues()
    // MARK: Bool
    func value(for key: LocalStorageBoolKey) -> Bool
    func set(_ value: Bool, for key: LocalStorageBoolKey)
    // MARK: Data
    func value(for key: LocalStorageDataKey) -> Data?
    func set(_ value: Data?, for key: LocalStorageDataKey)
    // MARK: String
    func value(for key: LocalStorageStringKey) -> String?
    func set(_ value: String?, for key: LocalStorageStringKey)
}

class LocalStorageService: LocalStorageServiceProtocol {
    private let defaults: AppleUserDefaults
    
    init(appleUserDefault: AppleUserDefaults) {
        self.defaults = appleUserDefault
    }
    
    func deleteAllValues() {
        self.defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    // MARK: Bool
    func value(for key: LocalStorageBoolKey) -> Bool {
        return self.defaults.bool(forKey: key.key)
    }
    
    func set(_ value: Bool, for key: LocalStorageBoolKey) {
        self.defaults.set(value, forKey: key.key)
    }
    
    // MARK: Data
    func value(for key: LocalStorageDataKey) -> Data? {
        return self.defaults.data(forKey: key.key)
    }
    
    func set(_ value: Data?, for key: LocalStorageDataKey) {
        self.defaults.set(value, forKey: key.key)
    }
    
    // MARK: String
    func value(for key: LocalStorageStringKey) -> String? {
        return self.defaults.string(forKey: key.key)
    }
    
    func set(_ value: String?, for key: LocalStorageStringKey) {
        self.defaults.set(value, forKey: key.key)
    }
}
