//
//  ContentView.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI




struct ContentView: View {
    
    @EnvironmentObject var model: WeatherModel
    
    @State var timer: Timer?
    @State private var isSharedPresented: Bool = false
    //@Environment(\.colorScheme) var colorScheme: ColorScheme

    var date: String {
        let date = model.currentWeather?.dt ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM dd, yyyy"
        return formatter.string(from: date)
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
    var temperature: Double {
        (model.currentWeather?.main?.temp ?? 273.15) - 273.15
    }
    var tempMin: Double {
        (model.currentWeather?.main?.tempMin ?? 273.15) - 273.15
    }
    var tempMax: Double {
        (model.currentWeather?.main?.tempMax ?? 273.15) - 273.15
    }
    var humidity: Int {
        (model.currentWeather?.main?.humidity ?? 0)
    }

    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                ShareButton(isSharedPresented: $isSharedPresented)
                    .position(x: geo.size.width - 40, y:  40)
                VStack {
                    
                    Text("\(weatherCity)".capitalized).font(.title).bold()
                    
                    Text("\(date)")
                        .multilineTextAlignment(.center)
                        .font(.body).opacity(0.5)
                        .padding(.bottom)
                    HStack {
                        Image(systemName: "thermometer").font(.largeTitle)
                        Text("\(temperature, specifier: "%.f")°").font(.largeTitle)
                    }
                    ZStack{
                        Circle().frame(width: 80, height: 80, alignment: .center).foregroundColor(.blue).opacity(0.4)
                        Image(uiImage: model.image ?? UIImage(named: "weather")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                    Text("\(weatherDescription)".capitalized).font(.body).bold()
                        .padding(.bottom).opacity(0.5)
                    
                    HStack {
                        Text("\(tempMax, specifier: "%.f")°").font(.title2).bold()
                        Text("\(tempMin, specifier: "%.f")°").font(.title2).opacity(0.8)
                    }
                    Text("Humidity: \(humidity) %").font(.title2).bold()
                        .padding().opacity(0.8)
                    WindRose(windSpeed: windSpeed)
                    Text(model.preferredLocations.debugDescription)
                }.position(x: geo.size.width / 2, y: geo.size.height * 4 / 9  )
                //.scaleEffect(geo.size.height / geo.size.width * 0.6 )
                
                
            }
            .sheet(isPresented: $isSharedPresented) {
                ActivityViewController(activityItems: [String(format:"The weather for \(weatherCity) on \(date): \(weatherDescription.capitalized) with a temperature of %.f degrees Celsius",temperature)])
            }
            .onAppear() {
                self.timer = Timer.scheduledTimer(withTimeInterval: 600, repeats: true, block: { _ in
                                                    model.updateWeather(for: model.currentCity)})
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
