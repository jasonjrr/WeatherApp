//
//  AppleUserDefaults.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation

protocol AppleUserDefaults: class {
    func bool(forKey defaultName: String) -> Bool
    func data(forKey defaultName: String) -> Data?
    func object(forKey defaultName: String) -> Any?
    func string(forKey defaultName: String) -> String?
    
    func set(_ value: Bool, forKey defaultName: String)
    func set(_ value: Any?, forKey defaultName: String)
    
    /*!
     -synchronize is deprecated and will be marked with the NS_DEPRECATED macro in a future release.
     
     -synchronize blocks the calling thread until all in-progress set operations have completed. This is no longer necessary. Replacements for previous uses of -synchronize depend on what the intent of calling synchronize was. If you synchronized...
     - ...before reading in order to fetch updated values: remove the synchronize call
     - ...after writing in order to notify another program to read: the other program can use KVO to observe the default without needing to notify
     - ...before exiting in a non-app (command line tool, agent, or daemon) process: call CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication)
     - ...for any other reason: remove the synchronize call
     */
    func synchronize() -> Bool
    
    /// -removePersistentDomainForName: removes all values from the search list entry specified by 'domainName', the current user, and any host. The change is persistent.
    func removePersistentDomain(forName domainName: String)
}

extension UserDefaults: AppleUserDefaults {}
