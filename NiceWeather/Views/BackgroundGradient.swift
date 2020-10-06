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
    let size: GeometryProxy
    
    var body: some View {
        AngularGradient(gradient: BackgroundColor.gradient, center: .center)
            .scaleEffect(4)
            .offset(x: -500.0, y: -40.0)
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
