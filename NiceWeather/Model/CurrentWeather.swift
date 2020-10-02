//
//  CurrentWeather.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

struct CurrentWeather: Codable {
    var coord: Coordinates?
    var weather: [Weather]?
    var base: Base?
    var main: MainWeatherData?
    var visibility: Double?
    var wind: Wind?
    var clouds: Cloud?
    var dt: Int?
    var sys: Sys?
    var cod: Int?
    
    struct Coordinates: Codable {
        var lon: Double?
        var lat: Double?
    }
    
    struct Weather: Codable {
        let id: Int?
        let main: String?
        var description: String?
        var icon: String?
    }
    
    struct Base: Codable {}
    
    struct MainWeatherData: Codable {
        let temp: Double?
        let feelsLike: Double?
        let tempMin: Double?
        let tempMax: Double?
        let pressure: Int?
        let humidity: Int?
    }
    
    struct Wind: Codable {
        let speed: Double?
        let deg: Int?
    }
    
    struct Sys: Codable {}
    
    struct Cloud: Codable {
        var all: Int?
    }
}

