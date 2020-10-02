//
//  ContentView.swift
//  NiceWeather
//
//  Created by Laurent B on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: WeatherModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Clouds: \(model.currentWeather?.clouds?.all ?? 0)")
                    .padding()
                Image(systemName: "line.3.crossed.swirl.circle.fill")
                
             Spacer()
            }
            .navigationBarTitle(Text("\(model.currentWeather?.name ?? "")"))
            .navigationBarItems(trailing:
                                Button(action: {})
                                    {Image(systemName: "square.and.arrow.up")})
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
