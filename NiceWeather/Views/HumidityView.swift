//
//  HumidityView.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct HumidityView: View {
    var model: WeatherModel
    var humidity: Int {
        model.currentWeather?.main.humidity ?? 0
    }
    
    var body: some View {
        Text("Humidity: \(humidity) %")
            .font(.title2)
            .bold()
            .opacity(0.8)
    }
}
