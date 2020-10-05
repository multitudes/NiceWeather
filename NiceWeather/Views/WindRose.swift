//
//  WindRose.swift
//  NiceWeather
//
//  Created by Laurent B on 03/10/2020.
//

import SwiftUI

struct WindRose: View {
    
    var windSpeed: Double
    var direction: Double
    @State private var isAnimating = false
    
    var windRoseAnimation: Animation {
        if isAnimating {
        return Animation.linear(duration: 8/windSpeed)
            .repeatForever(autoreverses: false)
        } else {
            return Animation.default
        }
    }
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "wind")
                Text("Wind speed: \(windSpeed, specifier: "%.1f") m/s ")
                Image(systemName: "paperplane.fill").rotationEffect(Angle(degrees: -45 + direction - 180))            }.font(Font.title2.monospacedDigit())
            .padding(5)
            if Int(windSpeed) != 0 {
                Image(systemName: "line.3.crossed.swirl.circle.fill").font(.system(size: 33, weight: .heavy)).accessibility(label: Text("wind speed animation"))
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


struct WindRose_Previews: PreviewProvider {
    static var previews: some View {
        WindRose(windSpeed: 1.2, direction: 45.0)
    }
}
