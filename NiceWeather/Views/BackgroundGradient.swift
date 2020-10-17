//
//  BackgroundGradient.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

enum BackgroundColor {
	static let gradient = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
}

struct BackgroundGradient: View {

	var body: some View {
		AngularGradient(gradient: BackgroundColor.gradient, center: .topLeading)
			.opacity(0.2)
			.ignoresSafeArea()
	}
}

struct BackgroundGradient_Previews: PreviewProvider {
	static var previews: some View {
		BackgroundGradient()
	}
}
