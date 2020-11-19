//
//  ShareButton.swift
//  NiceWeather
//
//  Created by Laurent B on 05/10/2020.
//

import SwiftUI

struct ShareButton: View {

	@Binding var isSharedPresented: Bool

	var body: some View {
		GeometryReader { geometry in
			Button(action: {
				self.isSharedPresented = true
			}) {
				SFSymbols.shareButton
					.accessibility(label: Text("share"))
					.font(Font.system(size: UIHelper.createShareButtonFontAdjustment(geo: geometry)))


			}
			.position(UIHelper.createShareButtonPaddingAdjustment(geo: geometry))
			.accentColor(.purple)
		}
	}
}
