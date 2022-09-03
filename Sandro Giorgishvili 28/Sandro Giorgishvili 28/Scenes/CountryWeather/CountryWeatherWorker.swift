//
//  CountryWeatherWorker.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 02.09.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CountryWeatherWorkerLogic {
    func fetchCountryWeather(request: CountryWeather.ShowCountryWeather.Request) async throws -> CountryMainWeather
}

class CountryWeatherWorker
{
    private var api: APIManager
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    private let apiKey = "8363f5cb5104fa0e6bdf946c6f5a585d"
    
    init(apiManager: APIManager) {
        self.api = apiManager
    }
    
    func setUpUrl(lat: Double, lon: Double) -> String {
        
        var urlComponent = URLComponents(string: baseUrl)
        
        urlComponent?.queryItems =  [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey)
            
        ]
        
        var request = URLRequest(url: (urlComponent?.url!)!)
        request.httpMethod = "GET"
        
        print(request)
        
        return "\(request)"
    }
}

extension CountryWeatherWorker: CountryWeatherWorkerLogic {
    func fetchCountryWeather(request: CountryWeather.ShowCountryWeather.Request) async throws -> CountryMainWeather {
        try await api.fetchData(urlString: setUpUrl(lat: request.laltitude, lon: request.longitude), decodingType: CountryMainWeather.self)
    }
}
