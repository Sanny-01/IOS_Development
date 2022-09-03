//
//  CountryWeatherModels.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 02.09.22.

import UIKit

enum CountryWeather
{
    // MARK: Use cases
    
    enum ShowCountryWeather {
        struct Request {
            let laltitude: Double
            let longitude: Double
        }
        
        struct Response {
            let countryWeahterData: CountryMainWeather
        }
        
        struct ViewModel {
            let currentWeather: String
        }
    }
}
