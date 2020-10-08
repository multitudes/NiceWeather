//
//  WeatherDescriptionView.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct WeatherDescriptionView: View {
    var image: UIImage?
    var weatherDescription: String
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.blue)
                    .opacity(0.4)
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }.accessibility(label: Text("current weather icon"))
            Text("\(weatherDescription)".capitalized).font(.body).bold()
                .padding(.bottom).opacity(0.5)
        }
    }
}
