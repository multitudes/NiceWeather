//
//  UIHelpers.swift
//  NiceWeather
//
//  Created by Laurent B on 18/10/2020.
//

import SwiftUI

enum UIHelper {
		// Small hack on the ContentView VStack spacing to adapt better on large devices like iPad:
		static func createSpacing(geo: GeometryProxy) -> CGFloat {
				return geo.size.height/50 + geo.size.width/100
		}

		static func createTitleSizeModifier(geo: GeometryProxy) -> CGFloat {
				return 33 + geo.size.height / 40
		}

		static func createShareButtonFontAdjustment(geo: GeometryProxy) -> CGFloat {
				return 10 + geo.size.width * 0.02
		}

		static func createShareButtonPaddingAdjustment(geo: GeometryProxy) -> CGPoint {
				return  CGPoint(x: geo.size.width - (25 + geo.size.width / 70), y: 25 + geo.size.width / 70)
		}
}
