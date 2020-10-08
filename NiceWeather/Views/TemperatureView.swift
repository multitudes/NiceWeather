//
//  TemperatureView.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct TemperatureView: View {
    var temperature: String
    
    var body: some View {
        HStack {
            SFSymbols.thermometer
                .font(.largeTitle)
            Text(temperature).font(.largeTitle)
        }
    }
}

