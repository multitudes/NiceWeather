//
//  ContentView.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: WeatherModel
    @State private var isSharedPresented: Bool = false
    var weatherDescription: String {
        model.currentWeather?.weather![0].description ?? ""
    }
    var weatherCity: String {
        (model.currentWeather?.name ?? "")
    }
    
    var windSpeed: Double {
        model.currentWeather?.wind?.speed ?? 0.0
    }
    var temperature: Double {
        (model.currentWeather?.main?.temp ?? 0.0) - 273.15
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(weatherCity)".capitalized).font(.largeTitle).bold()
                    .padding()
                Text("\(weatherDescription)".capitalized).font(.largeTitle)
                    .padding()
                HStack {
                    Image(systemName: "thermometer").font(.title)
                    Text("\(temperature, specifier: "%.f") ℃").font(.largeTitle)
                        .padding()
                }
                
                HStack{
                    Text("Wind speed \(windSpeed, specifier: "%.f")").font(.title)
                    Image(systemName: "line.3.crossed.swirl.circle.fill").font(.system(size: 33, weight: .heavy))
                    .animation(Animation.linear(duration: windSpeed))
                    .accessibility(label: Text("wind speed animation"))
                }
                Spacer()
            }
            .navigationBarTitle(Text(""))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.isSharedPresented = true
                                    }) {Image(systemName: "square.and.arrow.up")
                                        .accessibility(label: Text("share"))
                                    }).sheet(isPresented: $isSharedPresented) {
                                        ActivityViewController(activityItems: [String(format:"The weather for \(weatherCity) is \(weatherDescription.capitalized) with a temperature of %.f degrees Celsius",temperature)])
                                    }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
