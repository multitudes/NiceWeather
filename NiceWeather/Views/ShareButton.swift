//
//  ShareButton.swift
//  NiceWeather
//
//  Created by Laurent B on 05/10/2020.
//

import SwiftUI

struct ShareButton: View {
    
    @Binding var isSharedPresented: Bool
    
    var geo: GeometryProxy
    
    var body: some View {
        
        Button(action: {
            self.isSharedPresented = true
        }) {
            SFSymbols.shareButton
                .font(Font.system(size: UIHelper.createShareButtonFontAdjustment(geo: geo)))
                .accessibility(label: Text("share"))
            
        }
        .position(UIHelper.createShareButtonPaddingAdjustment(geo: geo))
        .accentColor(.purple)
    }
}
