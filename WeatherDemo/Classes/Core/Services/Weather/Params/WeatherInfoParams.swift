//
//  WeatherInfoParams.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation
import CoreLocation

struct WeatherInfoParams: Encodable {
    let latitude: Double
    let longitude: Double
    let apiKey: String
    let units: String
    
    init(coordinate: CLLocationCoordinate2D,
         apiKey: String = Constant.OpenWeather.apiKey,
         units: String = Constant.OpenWeather.units) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.apiKey = apiKey
        self.units = units
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case apiKey = "appid"
        case units
    }
}
