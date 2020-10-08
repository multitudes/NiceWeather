//
//  CurrentWeather.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import Foundation

struct CurrentWeather: Codable {
    
    //var coord: Coordinates
    var weather: [Weather]
    //var base: Base?
    var main: MainWeatherData
    //var visibility: Double?
    var wind: Wind?
    //var clouds: Cloud?
    var dt: Date
    //var sys: Sys?
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    struct Coordinates: Codable {
        var lon: Double
        var lat: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        var description: String
        var icon: String
    }
    
    struct Base: Codable {}
    
    struct MainWeatherData: Codable {
        let temp: Double
        let feelsLike: Double?
        let tempMin: Double
        let tempMax: Double
        let pressure: Int?
        let humidity: Int
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Double?
    }
    
    struct Sys: Codable {}
    
    struct Cloud: Codable {
        var all: Int?
    }
}

extension CurrentWeather {
    var datetime: String {
        let date = dt
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: timezone)
        formatter.dateFormat = "EEEE, MMMM dd, h:mm a"
        return formatter.string(from: date)
    }
    var degrees: Double {
        guard case wind?.deg = wind?.deg else { return 0.0 }
        return (-45 - 180) + ((wind?.deg)!)
    }
}
