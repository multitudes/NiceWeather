//
//  ContentView.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//
// need to merge 

import SwiftUI

struct ContentView: View {

	@AppStorage("weatherData",store: UserDefaults(suiteName: "group.com.laurentb.NiceWeather"))
	var weatherData: Data = Data()

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
    
    var windSpeed: (Double, String) {
        let speed: Double = model.currentWeather?.wind.speed ?? 0.0
        return (double: speed, stringFormatted: getSpeedformattedString(speed: speed))
    }
    
    var direction: Double {
        model.currentWeather?.degrees ?? 0.0
    }
    
    var temperature: String {
        model.currentWeather?.temperature ?? ""
    }
    
    var tempMin: String {
        model.currentWeather?.minTemperature ?? ""
    }
    
    var tempMax: String {
        model.currentWeather?.maxTemperature ?? ""
    }
    
    var humidity: String {
        let humidity = model.currentWeather?.main.humidity ?? 0
        return getHumidityPercentageFormattedString(humidity: humidity)
    }
    
    var sharedWeather: String {
        "\(weatherCity.capitalized):\n\(datetime)\n\(weatherDescription.capitalized)\n🌡 \(temperature)\n💨 \(windSpeed.1)\n💧 \(humidity)"
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
                    
                    HumidityView(humidity: humidity)
                    
                    WindRose(windSpeed: windSpeed, direction: direction)
                    
                    CityPicker(citySelection: $citySelection, model: model)
                    
                    Spacer()
                    
                }
            }
            .sheet(isPresented: $isSharedPresented) {
                ActivityViewController(activityItems: [sharedWeather])
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
