//
//  WeatherModel.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

// MARK: -

class WeatherModel: ObservableObject {
    
    @Published private(set) var currentWeather: CurrentWeather?
    @Published var currentCity: Location?
    @Published var image: UIImage? = nil

    init() {
            updateWeather(for: currentCity)
    }
    
    func updateWeather(for location: Location?){
        let loc = location ?? Location(city: "Berlin", countryCode: "DE")
        NetworkManager.shared.getWeather(for: loc.city, country: loc.countryCode) { result in
            switch result {
                case .success(let response):
                    print(response)
                    self.currentWeather = response
                    let icon = response.weather[0].icon
                    self.updateImage(icon: icon)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func updateImage(icon: String){
        print("icon \(icon)")
        NetworkManager.shared.downloadImage(from: icon) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}




