//
//  ContentView.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

enum UIHelper {
    // Small hack on the Vstack spacing to adapt better on large devices like iPad:
    static func createSpacing(geo: GeometryProxy) -> CGFloat {
        return geo.size.height/50 + geo.size.width/100
    }
    
    static func createTitleSizeModifier(geo: GeometryProxy) -> CGFloat {
        return 33 + geo.size.height / 40
    }
    
    static func createShareButtonFontAdjustment(geo: GeometryProxy) -> CGFloat {
        return 10 + geo.size.width * 0.03
    }
    
    static func createShareButtonPaddingAdjustment(geo: GeometryProxy) -> CGPoint {
        return  CGPoint(x: geo.size.width - (25 + geo.size.width / 70), y: 25 + geo.size.width / 70)
    }
}

struct ContentView: View {
    
    @StateObject private var model: WeatherModel = WeatherModel()
    
    @State private var timer: Timer?
    @State private var isSharedPresented: Bool = false
    @State private var citySelection: Location = WeatherModel.loadLastLocation()
    
//    var datetime: String {
//        let date = model.currentWeather?.dt ?? Date()
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone(secondsFromGMT: model.currentWeather?.timezone ?? 0)
//        formatter.dateFormat = "EEEE, MMMM dd, yyyy h:mm a"
//        return formatter.string(from: date)
//    }
    var datetime: String {
        model.currentWeather?.datetime ?? ""
    }
    var weatherDescription: String {
        model.currentWeather?.weather[0].description ?? ""
    }
    
    var weatherCity: String {
        model.currentWeather?.name ?? ""
    }
    
    var windSpeed: Double {
        model.currentWeather?.wind?.speed ?? 0.0
    }
    
    var direction: Double {
        model.currentWeather?.wind?.deg ?? 0.0
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
                    
                    if !Device.isiPhone {
                        DateTime(datetime: datetime )
                    }
                    
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
