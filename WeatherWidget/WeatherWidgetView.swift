//
//  WeatherWidgetView.swift
//  NiceWeather
//
//  Created by Laurent B on 17/10/2020.
//

import SwiftUI
import WidgetKit

struct WeatherWidgetData {
	let city: String
	let temperature: Measurement<UnitTemperature>
	let fetchDate: Date
}


extension WeatherWidgetData {
	static let previewData = WeatherWidgetData(city: "Berlin", temperature: Measurement<UnitTemperature>(value: 10, unit: .celsius), fetchDate: Date())
}

struct WeatherWidgetView: View {
	let data: WeatherWidgetData

	var body: some View {
		ZStack {
			BackgroundGradient()
			VStack(alignment: .leading) {
				Text("City")
					.font(.body)
					.foregroundColor(.gray)
					.bold()
			}
		}
	}
}

struct WeatherWidgetView_Previews: PreviewProvider {
	static var previews: some View {
		WeatherWidgetView(data: .previewData)
			.previewContext(WidgetPreviewContext(family: .systemSmall ))
	}
}
