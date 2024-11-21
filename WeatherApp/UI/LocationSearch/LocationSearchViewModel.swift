//
//  LocationSearchViewModel.swift
//  WeatherApp
//
//  Created by Jason Lew-Rapai on 11/21/24.
//

import Foundation
import Combine

@Observable
class LocationSearchViewModel: ViewModel {
    private let weatherAPIService: any WeatherAPIServiceProtocol
    private weak var delegate: Delegate?
    
    var query: String = .empty {
        didSet {
            self.querySubject.send(self.query)
        }
    }
    private let querySubject: CurrentValueSubject<String, Never> = CurrentValueSubject(.empty)
    
    private(set) var searchResult: Result<[CurrentWeatherViewModel], Error>?
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(weatherAPIService: any WeatherAPIServiceProtocol) {
        self.weatherAPIService = weatherAPIService
        
        self.querySubject
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .flatMapLatest { [weatherAPIService] query -> AnyPublisher<NetworkingServiceResponse<[Location]>?, Error> in
                if query.isEmpty {
                    return Just(nil)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    return weatherAPIService
                        .search(query)
                        .map { $0 }
                        .eraseToAnyPublisher()
                }
            }
            .map { [weatherAPIService] response -> Result<[CurrentWeatherViewModel], Error>? in
                if let locations = response?.model {
                    let viewModels = locations
                        .map {
                            CurrentWeatherViewModel(
                                location: $0,
                                weatherAPIService: weatherAPIService)
                        }
                    return .success(viewModels)
                } else {
                    return nil
                }
            }
            .catch { error in
                Just(.failure(error))
            }
            .sink(receiveValue: { [weak self] result in
                self?.searchResult = result
            })
            .store(in: &self.cancellables)
    }
    
    @discardableResult
    func setup(delegate: Delegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    func select(_ currentWeatherViewModel: CurrentWeatherViewModel) {
        self.delegate?.locationSearchViewModel(self, didSelect: currentWeatherViewModel)
    }
    
    func cancel() {
        self.delegate?.locationSearchViewModelDidCancel(self)
    }
}

extension LocationSearchViewModel {
    protocol Delegate: AnyObject {
        func locationSearchViewModel(_ source: LocationSearchViewModel, didSelect currentWeatherViewModel: CurrentWeatherViewModel)
        func locationSearchViewModelDidCancel(_ source: LocationSearchViewModel)
    }
}
