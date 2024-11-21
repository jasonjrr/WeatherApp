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
    
    private(set) var searchResult: Result<[Location], Error>?
    
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
            .map { response -> Result<[Location], Error>? in
                if let locations = response?.model {
                    return .success(locations)
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
    
    func cancel() {
        self.delegate?.locationSearchViewModelDidCancel(self)
    }
}

extension LocationSearchViewModel {
    protocol Delegate: AnyObject {
        func locationSearchViewModelDidCancel(_ source: LocationSearchViewModel)
    }
}
