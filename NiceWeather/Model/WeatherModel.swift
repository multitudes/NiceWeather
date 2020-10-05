//
//  WeatherModel.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

// MARK: -

class WeatherModel: ObservableObject {
    @EnvironmentObject var userStore: UserStore
    @Published private(set) var currentWeather: CurrentWeather?
    
    @Published var preferredLocations = loadLocations() {
      didSet {
        persistLocations()
      }
    }
    @Published var currentLocation: Location = loadLastLocation() {
        didSet {
            persistLastLocation()
        }
    }
    @Published var image: UIImage? = nil
    @Published var isDayTime: Bool = true
    
    static let locationsKey = "Locations"
    static let lastLocationKey = "Lastlocation"
    static let defaultLocations = [
      Location(city: "Berlin", countryCode: "DE"),
      Location(city: "Tokyo", countryCode: "JP"),
      Location(city: "Paris", countryCode: "FR"),
    ]
    static let defaultLastLocation = Location(city: "Berlin", countryCode: "DE")
    init() {
            updateWeather(for: currentLocation)
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
                    if icon[2] == "n" {
                        print("?")
                        self.isDayTime = false
                    }
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
    
    static func loadLocations() -> [Location] {
        let savedLocations = UserDefaults.standard.object(forKey: WeatherModel.locationsKey)
        if let savedLocations = savedLocations as? Data {
          let decoder = JSONDecoder()
          return (try? decoder.decode([Location].self, from: savedLocations))
            ?? WeatherModel.defaultLocations
        }
        return WeatherModel.defaultLocations
    }
    
    static func loadLastLocation() -> Location {
        let savedLastLocation = UserDefaults.standard.object(forKey: WeatherModel.lastLocationKey)
        if let lastLocation = savedLastLocation as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode(Location.self, from: lastLocation)) ?? WeatherModel.defaultLastLocation
        }
        return WeatherModel.defaultLastLocation
    }
    
    func updateLocation(with location: Published<Location>){
        self._currentLocation = location
    }
    
    func persistLocations() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(preferredLocations) {
            UserDefaults.standard.set(encoded, forKey: WeatherModel.locationsKey)
        }
    }
    
    func persistLastLocation() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(currentLocation) {
            UserDefaults.standard.set(encoded, forKey: WeatherModel.lastLocationKey)
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




