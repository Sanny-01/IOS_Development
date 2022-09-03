//
//  Country.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 30.08.22.
//

import Foundation

struct Country {
    let name: String
    let laltitude: Double
    let longitude: Double
}

struct CountryMainWeather: Decodable {
    let weather: [weatherType]
}

struct weatherType: Decodable {
    let main: String
}
