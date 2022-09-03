//
//  CountriesWorker.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 30.08.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CountriesWorkerLogic {
    func fetchCountries() -> [Country]
}

final class CountriesWorker: CountriesWorkerLogic {
    
    private var api: APIManager
    
    init(apiManager: APIManager) {
        self.api = apiManager
    }
    // MARK: - Methods
    
    func fetchCountries() -> [Country] {
        [
            Country(name: "Tbilisi", laltitude: 42.3154, longitude: 43.3569),
            Country(name: "Batumi", laltitude: 41.6168, longitude: 41.6367),
            Country(name: "Kutaisi", laltitude: 42.2662, longitude: 42.7180),
            Country(name: "Yerevan", laltitude: 40.1872, longitude: 44.5152),
            Country(name: "Baku", laltitude: 40.4093, longitude: 49.8671),
            Country(name: "Kyiv", laltitude: 50.4501, longitude: 30.5234),
            Country(name: "Washington", laltitude: 47.7511, longitude: 120.7401)
        ]
    }
}
