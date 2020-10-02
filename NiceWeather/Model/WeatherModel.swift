//
//  WeatherModel.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import Foundation

class WeatherModel: ObservableObject {
    
    @Published private(set) var currentWeather: CurrentWeather?
    @Published var currentCity: Location?
    
    init() {
        if let location = currentCity {
            updateWeather(for: location)
        } else {
            updateWeather(for: Location(city: "Berlin", countryCode: "DE"))
        }
    }
    
    func updateWeather(for location: Location){
        NetworkManager.shared.getWeather(for: location.city, country: location.countryCode) { result in
            switch result {
                case .success(let response):
                    print(response)
                    self.currentWeather = response
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}


