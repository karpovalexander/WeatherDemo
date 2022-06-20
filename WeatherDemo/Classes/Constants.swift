//
//  Constants.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

enum Constant {
    
    enum OpenWeather {
        static let apiKey = "126f998cf69a844408360135771ac393"
        static let baseUrl = "https://api.openweathermap.org/data/2.5"
        static let units = "metric"
    }
    
    enum WeatherUnits {
        static let locale = Locale(identifier: "ua_UA")
        static let temperature = UnitTemperature.celsius
        static let speed = UnitSpeed.kilometersPerHour
    }
}
