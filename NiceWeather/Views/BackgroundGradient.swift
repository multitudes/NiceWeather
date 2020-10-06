//
//  BackgroundGradient.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct BackgroundColor {
        static let gradient = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
}

struct BackgroundGradient: View {
    let geo: GeometryProxy
    
    var body: some View {
        AngularGradient(gradient: BackgroundColor.gradient, center: .center)
            .scaleEffect(4)
            .offset(x:  -geo.size.width * 0.75, y: -40.0)
            .opacity(0.2)
            .ignoresSafeArea()
    }
}
//
//struct BackgroundGradient_Previews: PreviewProvider {
//    static var previews: some View {
//        BackgroundGradient()
//    }
//}
