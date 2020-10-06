//
//  DateTime.swift
//  NiceWeather
//
//  Created by Laurent B on 06/10/2020.
//

import SwiftUI

struct DateTime: View {
    var date: String
    var time: String
    var geo: GeometryProxy
    
    var body: some View {
        Text("\(date) \(time)").opacity(0.5)
           .font(.body)
           // .position(x: geo.size.width / 2 , y: geo.size.height / 10)
            .multilineTextAlignment(.center)
        .padding(0)
    }
}

//struct DateTime_Previews: PreviewProvider {
//    static var previews: some View {
//        DateTime()
//    }
//}
