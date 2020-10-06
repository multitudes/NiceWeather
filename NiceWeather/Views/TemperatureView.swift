//
//  TemperatureView.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct TemperatureView: View {
    var temperature: Double
    
    var body: some View {
        HStack {
            Image(systemName: "thermometer").font(.largeTitle)
            Text("\(temperature, specifier: "%.f")°").font(.largeTitle)
        }
    }
}

//struct TemperatureView_Previews: PreviewProvider {
//    static var previews: some View {
//        TemperatureView()
//    }
//}
