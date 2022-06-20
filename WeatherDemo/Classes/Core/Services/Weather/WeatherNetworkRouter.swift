//
//  WeatherNetworkRouter.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Alamofire

enum WeatherNetworkRouter: URLRequestConvertible {
    case info(params: WeatherInfoParams)
}

extension WeatherNetworkRouter: NetworkRequestParams {
    
    var baseUrlPath: String {
        Constant.OpenWeather.baseUrl
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.queryString
    }

    
    var path: String {
        switch self {
        case .info:
            return "weather"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .info:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .info(params):
            return params.encode()
        }
    }
}

