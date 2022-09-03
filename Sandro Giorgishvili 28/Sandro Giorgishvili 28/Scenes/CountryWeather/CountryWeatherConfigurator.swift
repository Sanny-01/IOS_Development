//
//  CountryWeatherConfigurator.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 02.09.22.
//

import Foundation

enum CountryWeatherConfigurator {
    static func configure(with selectedCountry: Country) -> CountryWeatherViewController {
        let apiManager = APIManager()
        let worker = CountryWeatherWorker(apiManager: apiManager)
        let presenter = CountryWeatherPresenter()
        let interactor = CountryWeatherInteractor(presenter: presenter, worker: worker, selectedCountry: selectedCountry)
        let router = CountryWeatherRouter(dataStore: interactor)
        let viewController = CountryWeatherViewController(interactor: interactor, router: router)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
