//
//  Double +.swift
//  WeatherDemo
//
//  Created by AndUser on 20.06.2022.
//

import Foundation

extension Double {
    
    var formattedTemperature: String {
        let formatter = MeasurementFormatter()
        formatter.locale = Constant.WeatherUnits.locale
//        formatter.numberFormatter.maximumFractionDigits = 0
        let measurement = Measurement(value: self, unit: Constant.WeatherUnits.temperature)
        return formatter.string(from: measurement)
    }
    
    var formattedSpeed: String {
        let value = Measurement(value: self, unit: Constant.WeatherUnits.speed)
        let formatter = MeasurementFormatter()
        formatter.locale = Constant.WeatherUnits.locale
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter.string(from: value)
    }
}
