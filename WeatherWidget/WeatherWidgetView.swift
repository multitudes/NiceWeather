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

	var photoName: String? = nil

}


extension WeatherWidgetData {
	static let previewData = WeatherWidgetData(city: "Berlin", temperature: Measurement<UnitTemperature>(value: 10, unit: .celsius), fetchDate: Date(), photoName: "weather")
}

struct WeatherWidgetView: View {
	let data: WeatherWidgetData
	@Environment(\.widgetFamily) var widgetFamily

	var body: some View {
		ZStack {
			BackgroundGradient()

			HStack {
				VStack(alignment: .leading) {
					WeatherCityView(data: data)

					Spacer()

					TempView(data: data)
				}
				.padding(.all)

				if widgetFamily == .systemMedium,
					let photoName = data.photoName {
						Image(photoName)
							.resizable()
							.padding()
							.background(Color(.blue)).opacity(0.8)
				}
			}
		}
	}
}

struct WeatherCityView: View {
	let data: WeatherWidgetData

	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("City")
					.font(.body).bold()

				Spacer()

				Text(data.city)
					.font(.title)
					.bold()
					.minimumScaleFactor(0.8)
			}
			.padding(.all, 8.0)
			Spacer(minLength: 0)
		}
		.foregroundColor(.black).opacity(0.8)
		.background(ContainerRelativeShape().fill( Color(.cyan))).opacity(0.8)

	}
}

struct TempView: View {
	let data: WeatherWidgetData
	let measurementFormatter = MeasurementFormatter()

	var body: some View {
		VStack(alignment: .leading) {
			Text("Temp: \(measurementFormatter.string(from: data.temperature))")
				.font(.body)
				.bold()

			Text("\(data.fetchDate, style: .relative) ago")
				.font(.caption)
				.bold()
				.minimumScaleFactor(0.5)
		}
		.foregroundColor(.black).opacity(0.8)
	}
}

struct WeatherWidgetView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			WeatherWidgetView(data: .previewData)
				.previewContext(WidgetPreviewContext(family: .systemSmall ))
			WeatherWidgetView(data: .previewData)
				.previewContext(WidgetPreviewContext(family: .systemSmall ))
				.environment(\.colorScheme, .dark)
			WeatherWidgetView(data: .previewData)
				.previewContext(WidgetPreviewContext(family: .systemSmall ))
				.environment(\.sizeCategory, .extraExtraExtraLarge)
			WeatherWidgetView(data: .previewData)
				.previewContext(WidgetPreviewContext(family: .systemSmall ))
				.redacted(reason: .placeholder)
			WeatherWidgetView(data: .previewData)
				.previewContext(WidgetPreviewContext(family: .systemMedium ))
		}
	}
}
