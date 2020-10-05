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
        
        Button(action: {
            self.isSharedPresented = true
        }) {
            Image(systemName: "square.and.arrow.up")
                .accessibility(label: Text("share"))
        }
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton(isSharedPresented: .constant(false))
    }
}
