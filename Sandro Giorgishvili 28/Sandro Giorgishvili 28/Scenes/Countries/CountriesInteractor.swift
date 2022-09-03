//
//  CountriesInteractor.swift
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

protocol CountriesBusinessLogic
{
    func getCountries(request: Countries.GetCountries.Request)
    func didTapCountry(request: Countries.ShowCountryDetails.Request)
}

protocol CountriesDataStore {
    var selectedCountry: Country? { get }
}

class CountriesInteractor: CountriesDataStore
{
    var countries = [Country]()
    private(set) var selectedCountry: Country?
    
    var presenter: CountriesPresentationLogic
    var worker: CountriesWorkerLogic
    
    // MARK: Do something
    
    init(presenter: CountriesPresentationLogic, worker: CountriesWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension CountriesInteractor: CountriesBusinessLogic {
    func didTapCountry(request: Countries.ShowCountryDetails.Request) {
        self.selectedCountry = countries.first { $0.name == request.selectedCountryName}
        presenter.presentSelectedCountry(response: Countries.ShowCountryDetails.Response())
    }
    
    func getCountries(request: Countries.GetCountries.Request) {
        
        let countries = worker.fetchCountries()
        self.countries = countries
        
        self.presenter.presentCountries(response: Countries.GetCountries.Response(data: countries))
    }
}
