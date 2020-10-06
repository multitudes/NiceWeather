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
            .font(.custom("SF-Pro-Text-Medium", size: UIHelper.createTitleSizeModifier(geo: geo)))
            .bold()
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .frame(maxHeight:200)
            .padding(.horizontal, 70)
    }
}
