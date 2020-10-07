//
//  WeatherModel.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

// MARK: - Extension with static variables

extension WeatherModel {
    static let locationsKey = "Locations"
    static let lastLocationKey = "Lastlocation"
    static let defaultLastLocation = Location(city: "Berlin", countryCode: "DE")
    static let defaultLocations = [
        Location(city: "Berlin", countryCode: "DE"),
        Location(city: "Tokyo", countryCode: "JP"),
        Location(city: "Paris", countryCode: "FR"),
    ]
}

// MARK: - Main Class

class WeatherModel: ObservableObject {
    
    @Published var currentWeather: CurrentWeather?
    
    @Published var currentLocation: Location = loadLastLocation() {
        didSet {
            persistLastLocation()
        }
    }

    @Published var preferredLocations = loadLocations() {
        didSet {
            persistLocations()
        }
    }
 
    @Published var image: UIImage? = nil
    
    @Published var isDayTime: Bool = true
    
    init() {
        updateWeather()
    }
    
    func updateWeather(){
        let loc = WeatherModel.loadLastLocation()
        NetworkManager.shared.getWeather(for: loc.city, country: loc.countryCode) { result in
            switch result {
                case .success(let response):
                    print(response) //check
                    self.currentWeather = response
                    let icon = response.weather[0].icon
                    self.updateImage(icon: icon)
                    // I found out that the images returned at night time at the location have a format ending with n like '04n'and are better suitable for displaying in dark mode.
                    if icon[2] == "n" {
                        print("NightMode!")
                        self.isDayTime = false
                    } else {
                        self.isDayTime = true
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    static func loadLastLocation() -> Location {
        let savedLastLocation = UserDefaults.standard.object(forKey: WeatherModel.lastLocationKey)
        if let lastLocation = savedLastLocation as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode(Location.self, from: lastLocation)) ?? WeatherModel.defaultLastLocation
        }
        return WeatherModel.defaultLastLocation
    }
    
    func updateImage(icon: String){
        print("icon \(icon)")
        NetworkManager.shared.downloadImage(from: icon) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
    static func loadLocations() -> [Location] {
        let savedLocations = UserDefaults.standard.object(forKey: WeatherModel.locationsKey)
        if let savedLocations = savedLocations as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([Location].self, from: savedLocations))
                ?? WeatherModel.defaultLocations
        }
        return WeatherModel.defaultLocations
    }
    
    func persistLastLocation() {
        print("persistLastLocation")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentLocation) {
            UserDefaults.standard.set(encoded, forKey: WeatherModel.lastLocationKey)
        }
    }
    
    // TODO: - editing locations not yet implemented in app
    func updateLocation(with location: Location){
        print(location)
        self.currentLocation = location
    }
    
    func persistLocations() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(preferredLocations) {
            UserDefaults.standard.set(encoded, forKey: WeatherModel.locationsKey)
        }
    }
    
    func addlocation(city: String, country: String) {
        let newLocation = Location(city: city, countryCode: country)
        preferredLocations.append(newLocation)
    }
    
    func deleteLocation(at offsets: IndexSet) {
        preferredLocations.remove(atOffsets: offsets)
    }
}


