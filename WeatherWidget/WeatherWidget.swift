//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Laurent B on 17/10/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
			SimpleEntry(date: Date(), weather: .previewData)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
			let entry = SimpleEntry(date: Date(), weather: .previewData)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), weather: .previewData)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
		let weather: WeatherWidgetData
}

struct PlaceholderView: View {

		var body: some View {
			WeatherWidgetView(data: .previewData)
				//.isPlaceholder(true) not yet avalaible
				.redacted(reason: .placeholder)
		}
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
			WeatherWidgetView(data: entry.weather)
    }
}

@main
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("NiceWeather")
        .description("Display your favourite weather!")
				.supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
			WeatherWidgetView(data: .previewData)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
			PlaceholderView()
						.previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
