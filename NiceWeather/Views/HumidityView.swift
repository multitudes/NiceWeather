//
//  HumidityView.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct HumidityView: View {
    var humidity: String
    
    var body: some View {
			HStack {
				SFSymbols.humidity.accessibility(label: Text("wind direction"))
				Text(humidity)
			}
       // Text("Humidity: \(humidity)")
            .font(.title2)
            .opacity(0.8)
    }
}
