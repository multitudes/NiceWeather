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
            Image(systemName: "square.and.arrow.up")
                .font(Font.system(size: 10 + geo.size.width * 0.03))
                .padding()
                .accessibility(label: Text("share"))
            
        }
        .position(x: geo.size.width - 40, y:  40)
        .accentColor(.purple)
    }
}
//
//struct ShareButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareButton(isSharedPresented: .constant(false))
//    }
//}
