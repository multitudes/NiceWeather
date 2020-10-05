//
//  LocationPicker.swift
//  NiceWeather
//
//  Created by Laurent B on 05/10/2020.
//

import SwiftUI

struct LocationPicker: View {
    @EnvironmentObject var model: WeatherModel
    @Binding var location: Location
    var body: some View {
        Picker(selection: $location, label: Spacer()) {
            ForEach(model.preferredLocations, id: \.self) {
                Text($0.city)
            }
        }
        
    }
}


//struct GenrePicker: View {
//  @Binding var genre: String
//
//    var body: some View {
//      Picker(selection: $genre, label: Spacer()) {
//        ForEach(Movie.possibleGenres, id: \.self) {
//          Text($0)
//        }
//      }
//      .pickerStyle(WheelPickerStyle())
//    }
//}

struct LocationPicker_Previews: PreviewProvider {
    static var previews: some View {
        LocationPicker(location: .constant(Location(city: "Berlin", countryCode: "de")))
    }
}
