//
//  ContentView.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model: WeatherModel = WeatherModel()
    
    @State private var timer: Timer?
    @State private var isSharedPresented: Bool = false
    @State private var citySelection: Location = WeatherModel.loadLastLocation()

    var datetime: String {
        model.currentWeather?.datetime ?? ""
    }
    var weatherDescription: String {
        model.currentWeather?.weather[0].description ?? ""
    }
    
    var weatherCity: String {
        model.currentWeather?.name ?? "Nowhere"
    }
    
    var windSpeed: Double {
        model.currentWeather?.wind?.speed ?? 0.0
    }
    
    var direction: Double {
        model.currentWeather?.degrees ?? 0.0
    }
    
    var temperature: Double {
        model.currentWeather?.main.temp ?? 0.0
    }
    
    var tempMin: Double {
        model.currentWeather?.main.tempMin ?? 0.0
    }
    
    var tempMax: Double {
        model.currentWeather?.main.tempMax ?? 0.0
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                BackgroundGradient(geo: geo)
                
                // this is to be able to use the app with catalyst on macOS
                if Device.isiPhone || Device.isiPad {
                    ShareButton(isSharedPresented: $isSharedPresented, geo: geo)
                } else {
                    EmptyView()
                }
                
                VStack(spacing: UIHelper.createSpacing(geo: geo)) {
                    Spacer()
                    
                    CityTitle(city: weatherCity, geo: geo)
                    
                    DateTime(datetime: datetime )
                    
                    TemperatureView(temperature: temperature)
                    
                    WeatherDescriptionView(image: model.image, weatherDescription: weatherDescription)
                    
                    TempMaxMin(tempMin: tempMin , tempMax: tempMax)
                    
                    HumidityView(model: model)
                    
                    WindRose(windSpeed: windSpeed, direction: direction)
                    
                    CityPicker(citySelection: $citySelection, model: model)
                    
                    Spacer()
                    
                }
            }
            .sheet(isPresented: $isSharedPresented) {
                ActivityViewController(activityItems: [String(format:"The weather for \(weatherCity) as of \(datetime): \(weatherDescription.capitalized) with a temperature of %.f degrees Celsius",temperature)])
                    .environment(\.colorScheme, model.isDayTime ? .light : .dark )
            }
            .alert(isPresented: $model.loadingError) {
                Alert(title: Text("The weather could not be loaded"), message: Text("Pls check your network connection"), dismissButton: .default(Text("OK")))
            }
            .onAppear() {
                self.timer = Timer.scheduledTimer(withTimeInterval: 600, repeats: true, block: { _ in
                    model.updateWeather()
                })
            }
            .onDisappear() {
                timer?.invalidate()
            }
            .preferredColorScheme(model.isDayTime ? .light : .dark )
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
