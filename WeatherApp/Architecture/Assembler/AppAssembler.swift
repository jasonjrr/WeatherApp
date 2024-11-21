//
//  AppAssembler.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/20/24.
//

import Foundation
import Swinject

class AppAssembler {
    private let assembler: Assembler
    
    var resolver: Resolver {
        self.assembler.resolver
    }
    
    init() {
        self.assembler = Assembler([
            NavigationCoordinatorAssembly(),
            ServicesAssembly(),
            ViewModelAssembly(),
        ])
    }
}
