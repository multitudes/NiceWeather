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
    
    var adjustment: CGFloat {
        25 + geo.size.width / 70
    }
    var fontAdjustment: CGFloat {
        10 + geo.size.width * 0.03
    }
    
    var body: some View {
        
        Button(action: {
            self.isSharedPresented = true
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(Font.system(size: fontAdjustment))
                .accessibility(label: Text("share"))
            
        }
        .position(x: geo.size.width - adjustment, y:  adjustment)
        .accentColor(.purple)
    }
}
