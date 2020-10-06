//
//  TempMaxMin.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct TempMaxMin: View {
    var tempMin: Double
    var tempMax: Double
    
    var body: some View {
        HStack {
            Text("\(tempMax, specifier: "%.f")°").font(.title2).bold()
            Text("\(tempMin, specifier: "%.f")°").font(.title2).opacity(0.8)
        }
    }
}

//struct TempMaxMin_Previews: PreviewProvider {
//    static var previews: some View {
//        TempMaxMin()
//    }
//}
