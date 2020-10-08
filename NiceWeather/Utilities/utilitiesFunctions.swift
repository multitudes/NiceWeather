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

func getSpeedformattedString(speed: Double) -> String {
    let formatter = MeasurementFormatter()
    let speed = Measurement<UnitSpeed>(value: speed, unit: .metersPerSecond)
    formatter.numberFormatter.maximumFractionDigits = 1
    return formatter.string(from: speed)
}

func getHumidityPercentageFormattedString(humidity: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    let NShumidity = NSNumber(value:(humidity) / 100)
    return formatter.string(from: NShumidity)!
}
