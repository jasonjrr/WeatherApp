//
//  AppleUserDefaults.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

protocol AppleUserDefaults: AnyObject {
    func bool(forKey defaultName: String) -> Bool
    func data(forKey defaultName: String) -> Data?
    func object(forKey defaultName: String) -> Any?
    func string(forKey defaultName: String) -> String?
    
    func set(_ value: Bool, forKey defaultName: String)
    func set(_ value: Any?, forKey defaultName: String)
    
    /// -removePersistentDomainForName: removes all values from the search list entry specified by 'domainName', the current user, and any host. The change is persistent.
    func removePersistentDomain(forName domainName: String)
}

extension UserDefaults: AppleUserDefaults {}
