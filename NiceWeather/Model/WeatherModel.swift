//
//  WeatherModel.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import Foundation

class WeatherModel: ObservableObject {
    
    @Published private(set) var currentWeather: CurrentWeather?
    @Published var currentCity: City?
    
    init() {
        if let city = currentCity {
            updateWeather(for: city)
        } else {
            updateWeather(for: City(city: "Berlin", countryCode: "DE"))
        }
    }

    func updateWeather(for city: City){

    }
   
}
