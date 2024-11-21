//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation

protocol ViewModel: AnyObject, Identifiable, Hashable, Equatable {}

extension ViewModel {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
