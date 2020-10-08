//
//  TempMaxMin.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct TempMaxMin: View {
    var tempMin: String
    var tempMax: String
    
    var body: some View {
        HStack {
            Text(tempMax).font(.title2).bold()
            Text(tempMin).font(.title2).opacity(0.8)
        }
    }
}
