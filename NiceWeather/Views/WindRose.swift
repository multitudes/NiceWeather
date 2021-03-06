//
//  WindRose.swift
//  NiceWeather
//
//  Created by Laurent B on 03/10/2020.
//

import SwiftUI

struct WindRose: View {
    @State private var isAnimating = false
    
    var windSpeed: (Double, String)
    var direction: Double

    var windRoseAnimation: Animation {
        if isAnimating {
            return Animation.linear(duration: 8/windSpeed.0)
                .repeatForever(autoreverses: false)
        } else {
            return Animation.linear(duration: 8/windSpeed.0)
        }
    }
    
    var body: some View {
        VStack {
            HStack{
                SFSymbols.wind
                Text(windSpeed.1)
                SFSymbols.windDirection
                    .rotationEffect(Angle(degrees: direction))
                    .accessibility(label: Text("wind direction"))
            }
            .font(Font.title2.monospacedDigit())
            .padding(5)
            
            if Int(windSpeed.0) != 0 {
                SFSymbols.windRose
                    .font(.system(size: 33, weight: .heavy))
                    .accessibility(label: Text("wind speed animation"))
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                    .animation(windRoseAnimation)
                    .onAppear { self.isAnimating = true }
                    .onDisappear { self.isAnimating = false }
            } else {
                Image(systemName: "line.3.crossed.swirl.circle.fill").font(.system(size: 33, weight: .heavy))
            }
        }
    }
}


//struct WindRose_Previews: PreviewProvider {
//    static var previews: some View {
//        WindRose(windSpeed: 4.2, direction: 45.0)
//    }
//}
