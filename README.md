
<img src="icons/weather.svg" width="100"  title="app">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

# Nice Weather App (in progress)

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

The app will be entirely written in Swift without external libraries. I will develop the app using the new Apple framework SwiftUI universal.  

<br>
<p align="center">

<img src="images/PushingBoundaries/pushingBoundaries2.png" width="230"  title="NiceWeather">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<br></br>

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
From the API response I will build the model as a struct conforming to the Codable protocol. From the docs I read that some of these variables are not guaranteed to exist in every API response so I will make them optional. Also I will not probaly use all of them.

```swift
struct CurrentWeather: Codable {
      var coord: Coordinates
      var weather: [Weather]?
      var base: Base?
      var main: MainWeatherData
      var visibility: Double?
      var wind: Wind
      var clouds: Cloud
      var dt: Int?
      var sys: Sys?
      var timezone: Int
      var id: Int
      var name: String
      var cod: Int

      struct Coordinates: Codable {
          var lat: Double
          var lon: Double
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

### The NetworkManager
I create a separate `NetworkManager` class which will take care of my network calls. In this class I will call its method `getWeather(for city:country:)` from my viewmodel to get the current weather data and pass it to the view.

### ATS - Apple Transport Security
I got the error message:
>2020-10-02 14:42:14.713320+0200 NiceWeather[98370:5805877] App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.

Clearly Apple doesnt like URL's starting with `HTTP`. I need to add this to my `.plist` file:
```
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
```

### My Data
I get in the console the converted json data. 
Time to do the layout in my views. 
I will add a picker with a list of cities to chose from. This can be customized later to add more cities, or the user can add cities  to the app.
For the wind animation I will use an icon in SF Symbols which will rotate with a speed depending of the intensity of the wind.


### Accessibility
Where needed I added labels to buttons that would be difficult for Voiceover to spell like in the sharing button:
```
            .navigationBarItems(trailing:
                Button(action: {}) {Image(systemName: "square.and.arrow.up")
                                    .accessibility(label: Text("share"))
                })
```

### Resources used
- jsonbeautify to display and validate JSON files: https://jsonbeautify.com
- App Icon from Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a> and resized with [Sketch](https://www.sketch.com) 
