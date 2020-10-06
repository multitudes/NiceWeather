//
//  CityPicker.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct CityPicker: View {
    
    @Binding var citySelection: Location
    var model: WeatherModel
    
    var body: some View {
        Picker(selection: $citySelection, label: Text("") ) {
            ForEach(model.preferredLocations, id: \.self) {
                Text($0.city).font(.system(.title2))
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(width: 150, height: 50, alignment: .center).padding()
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onChange(of: citySelection, perform: { value in
            model.updateLocation(with: value)
            model.updateWeather()
        })
    }
}

//struct CityPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CityPicker()
//    }
//}
