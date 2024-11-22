//
//  LocationSearchViewModel+Alert.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import SwiftUI

extension LocationSearchViewModel {
    struct Alert: Identifiable, Equatable {
        let id: UUID = UUID()
        let title: String
        let message: String?
        let actions: [Alert.Action]
        
        init(title: String, message: String?, actions: [Alert.Action]) {
            self.title = title
            self.message = message
            self.actions = actions
        }
        
        static func ==(lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id
        }
    }
}

extension LocationSearchViewModel.Alert {
    struct Action: Identifiable {
        let id: UUID = UUID()
        let label: String?
        let role: ButtonRole?
        let handler: (() -> Void)?
        
        static func action(label: String? = nil, role: ButtonRole? = nil, handler: (() -> Void)? = nil) -> Action {
            Action(label: label, role: role, handler: handler)
        }
        
        static func cancel(label: String? = "Cancel", handler: (() -> Void)? = nil) -> Action {
            Action(label: label, role: .cancel, handler: handler)
        }
        
        static func destructive(label: String, handler: (() -> Void)? = nil) -> Action {
            Action(label: label, role: .destructive, handler: handler)
        }
        
        static func ok(_ handler: (() -> Void)? = nil) -> Action {
            Action(label: "OK", role: nil, handler: handler)
        }
    }
}
