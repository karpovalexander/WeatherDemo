//
//  City.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation
import CoreLocation

struct City: Decodable {
    let id: Int
    let name: String
    let state: String
    let countryCode: String
    let coordinate: CLLocationCoordinate2D
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case state
        case countryCode = "country"
        case coordinate = "coord"
    }
    
    enum CoordinateCodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coordinateContainer = try container.nestedContainer(keyedBy: CoordinateCodingKeys.self, forKey: .coordinate)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        state = try container.decode(String.self, forKey: .state)
        countryCode = try container.decode(String.self, forKey: .countryCode)
        
        let latitude = try coordinateContainer.decode(Double.self, forKey: .latitude)
        let longitude = try coordinateContainer.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
