//
//  DateTime.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct DateTime: View {
    var datetime: String
    
    var body: some View {
        Text("\(datetime)")
            .opacity(0.5)
            .font(.title2)
            .multilineTextAlignment(.center)
            .padding(0)
    }
}
