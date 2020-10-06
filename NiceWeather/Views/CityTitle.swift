//
//  CityTitle.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct CityTitle: View {
    var city: String
    var geo: GeometryProxy
    var body: some View {
        Text("\(city)".capitalized)
            .font(.custom("SF-Pro-Text-Medium", size: 33 + geo.size.height / 40)).bold()
          //  .position(x: geo.size.width / 2 , y: geo.size.height / 8)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .frame(maxWidth:400 ,maxHeight:100)
            .padding(.horizontal, 70)
            

    }
}

//struct CityTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        CityTitle()
//    }
//}
