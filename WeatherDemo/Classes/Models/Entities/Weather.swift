//
//  Weather.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

struct Weather {
    
    private struct WeatherInfo: Decodable {
        let description: String?
    }
    
    let description: String?
    let currentTemperature: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let humidity: Double
    let windSpeed: Double
    
    var dispayCurrentTemperature: String {
        currentTemperature.formattedTemperature
    }
    
    var displayMinimumTemperature: String {
        minimumTemperature.formattedTemperature
    }
    
    var displayMaximumTemperature: String {
        maximumTemperature.formattedTemperature
    }
    
    var displayHumidity: String {
        "\(Int(humidity)) %"
    }
    
    var displaySpeed: String {
        windSpeed.formattedSpeed
    }
}

extension Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case weather
        case mainData = "main"
        case wind
    }
    
    enum MainDataCodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case humidity = "humidity"
    }
    
    enum WindCodingKeys: String, CodingKey {
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let mainDataContainer = try container.nestedContainer(keyedBy: MainDataCodingKeys.self, forKey: .mainData)
        let windContainer = try container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        
        description = try container.decode([WeatherInfo].self, forKey: .weather).first?.description
        currentTemperature = try mainDataContainer.decode(Double.self, forKey: .currentTemperature)
        minimumTemperature = try mainDataContainer.decode(Double.self, forKey: .minimumTemperature)
        maximumTemperature = try mainDataContainer.decode(Double.self, forKey: .maximumTemperature)
        humidity = try mainDataContainer.decode(Double.self, forKey: .humidity)
        windSpeed = try windContainer.decode(Double.self, forKey: .speed)
    }
}
