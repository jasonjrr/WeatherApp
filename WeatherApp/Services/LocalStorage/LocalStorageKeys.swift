//
//  LocalStorageKeys.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

enum LocalStorageBoolKey: String, CaseIterable {
    case placeholderBool
    
    var key: String {
        "bool:" + self.rawValue
    }
}

enum LocalStorageDataKey: String, CaseIterable {
    case location
    
    var key: String {
        "data:" + self.rawValue
    }
}

enum LocalStorageStringKey: String, CaseIterable {
    case placeholderString
    
    var key: String {
        "string:" + self.rawValue
    }
}
