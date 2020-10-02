# SmallWeatherApp

### Weather App Challenge
Build a small app which displays a weather forecast for Berlin using http://openweathermap.org/

#### Requirements
- Application can be easily extended to support more cities (list of cities included with app’s)
- Weather detail screen uses images from the API response
- Wind speed value presented with animation.

#### Bonus
- Alternative layout for bigger screens
- Allow sharing weather to other people
- Unit test

## The execution

The app will be entirely written in Swift without external libraries. I will develop the app using the new Apple framework SwiftUI universal and trhe MVVM design pattern.

### The API
This is a preview of the API response for Berlin using http://openweathermap.org/ (I used JsonBeautify for the formatting):

```json
{
  "coord": {
    "lon": 13.41,
    "lat": 52.52
  },
  "weather": [
    {
      "id": 701,
      "main": "Mist",
      "description": "mist",
      "icon": "50d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 285.2,
    "feels_like": 285.14,
    "temp_min": 283.15,
    "temp_max": 288.15,
    "pressure": 1008,
    "humidity": 100
  },
  "visibility": 1000,
  "wind": {
    "speed": 1,
    "deg": 0
  },
  "clouds": {
    "all": 75
  },
  "dt": 1601541645,
  "sys": {
    "type": 1,
    "id": 1275,
    "country": "DE",
    "sunrise": 1601528872,
    "sunset": 1601570629
  },
  "timezone": 7200,
  "id": 2950159,
  "name": "Berlin",
  "cod": 200
}
```

### The Model
The model is indipendent from the view and closely matches the response I get from the API.
From the API response I will build the model as a struct conforming to the Codable protocol. From the docs I read that these variables are not guaranteed to exist in every API response so I will make them optional. Also I will not probaly use all of them.

```swift
struct CurrentWeather: Codable {
      var coord: Coordinates?
      var weather: [Weather]?
      var base: Base?
      var main: MainWeatherData?
      var visibility: Double?
      var wind: Wind?
      var clouds: Cloud?
      var dt: Int?
      var sys: Sys?
      var cod: Int?

      struct Coordinates: Codable {
      var lat: Double?
      var lon: Double?
      }
      [...]

}
```

### The viewmodel

The viewmodel will use the model to convert the API call to data for our views. It will be a class conforming to the `ObservableObject` protocol and use a property wrapper `@Published` to pass the data to our views. When a published property changes, SwiftUI will refresh our views automatically. This class will be our source of truth!
Also the app will remember the last selected city or preferred city.

```swift
class WeatherModel: ObservableObject {
    
    @Published private(set) var currentWeather: CurrentWeather?
    @Published var currentCity: City?
    
    [...]
```

In SwiftUI we do not have the files AppDelagate.swift and Scene.swift anymore, our data will be initialized in the `NiceWeatherApp.swift` file as an `environmentObject`.

```swift
import SwiftUI

@main
struct NiceWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WeatherModel())
        }
    }
}
```

### Resources used
- jsonbeautify to display and validate JSON files: https://jsonbeautify.com
