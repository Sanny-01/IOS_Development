//
//  CountryWeatherRouter.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 02.09.22.

import UIKit

protocol CountryWeatherRoutingLogic { }

protocol CountryWeatherDataPassing {
    var dataStore: CountryWeatherDataStore { get }
}

final class CountryWeatherRouter: CountryWeatherRoutingLogic, CountryWeatherDataPassing {
    // MARK: - Clean Components
    
    weak var viewController: CountryWeatherViewController?
    private(set) var dataStore: CountryWeatherDataStore
    
    // MARK: - Object Lifecycle
    
    init(dataStore: CountryWeatherDataStore) {
        self.dataStore = dataStore
    }
}
