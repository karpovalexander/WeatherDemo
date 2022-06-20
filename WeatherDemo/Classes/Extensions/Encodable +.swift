//
//  Encodable.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Alamofire

extension Encodable {
    
    func encode(dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate) -> Parameters {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dateEncodingStrategy
        let encodedData = try? encoder.encode(self)
        let parameters = try? JSONSerialization.jsonObject(with: encodedData!, options: [])
        return parameters as! Parameters
    }
}
