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

enum LocalStorageDateKey: String, CaseIterable {
    case placeholderDate
    
    var key: String {
        "date:" + self.rawValue
    }
}

enum LocalStorageStringKey: String, CaseIterable {
    case placeholderString
    
    var key: String {
        "string:" + self.rawValue
    }
}

enum LocalStorageStringArrayKey: String, CaseIterable {
    case placeholderStringArray
    
    var key: String {
        "string-array:" + self.rawValue
    }
}
