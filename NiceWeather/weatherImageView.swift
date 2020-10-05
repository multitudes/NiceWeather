//
//  weatherImageView.swift
//  NiceWeather
//
//  Created by Laurent B on 03/10/2020.
//

import SwiftUI


struct weatherImageView: View {
    //@ObservedObject var image = UrlImage()
    @EnvironmentObject var model: WeatherModel
    static var defaultImage = UIImage(named: "weather")
    var icon: String
    
    var body: some View {
        Image(uiImage: model.image ?? UIImage(named: "weather")!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
        onAppear(){
          //  model.updateImage(icon: icon)
        }
    }
 
}

struct weatherImageView_Previews: PreviewProvider {
    static var previews: some View {
        weatherImageView(icon: "01d")
    }
}
