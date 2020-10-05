//
//  NiceWeatherApp.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

@main
struct NiceWeatherApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
              //  .environmentObject(WeatherModel(location: Location(city: "Berlin", countryCode: "De")))
                .environmentObject(UserStore())
                //.environment(\.colorScheme, .dark) // or .dark
        }
    }
}
