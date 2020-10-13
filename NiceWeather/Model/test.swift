//
//  test.swift
//  NiceWeather
//
//  Created by Laurent B on 09/10/2020.
//

import SwiftUI

struct test: View {

	var today: String {
		let date = Date()
		let formatter = DateFormatter()
		formatter.locale = .autoupdatingCurrent
		formatter.setLocalizedDateFormatFromTemplate("E")
		return formatter.string(from: date)
	}

	// or edited from Leo Dabus
	static let weekDay: DateFormatter = {
					let formatter = DateFormatter()
					formatter.locale = Locale(identifier: "zh")
					formatter.setLocalizedDateFormatFromTemplate("E")
					return formatter
			}()

	var body: some View {
		Text("\(today) \(Self.weekDay.string(from: Date()))")
		}
}

struct test_Previews: PreviewProvider {
	static var previews: some View {
		test()
	}
}
