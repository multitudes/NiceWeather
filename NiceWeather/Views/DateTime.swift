//
//  DateTime.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct DateTime: View {
    var datetime: String
    var fontSize: CGFloat {
        if Device.isiPhone {
            return 18.0
        } else {
            return 28.0
        }
    }
    
    var body: some View {
        Text("\(datetime)")
            // .opacity(0.5)
            .foregroundColor(.gray)
            .font(.system(size: fontSize))
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding(0)
    }
}
