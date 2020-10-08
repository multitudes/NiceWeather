//
//  utilitiesFunctions.swift
//  NiceWeather
//
//  Created by Laurent B on 08/10/2020.
//

import Foundation

func getTempformattedString(temp: Double) -> String {
    let formatter = MeasurementFormatter()
    let temperature = Measurement<UnitTemperature>(value: temp, unit: .celsius)
    formatter.numberFormatter.maximumFractionDigits = 0
    return formatter.string(from: temperature)
}
