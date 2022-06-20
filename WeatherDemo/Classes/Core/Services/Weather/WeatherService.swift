//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

typealias WeatherInfoCompletionHandler = (Result<Weather>) -> Void

protocol WeatherServiceProtocol {
    func info(params: WeatherInfoParams, completionHandler: @escaping WeatherInfoCompletionHandler)
}

final class WeatherService: WeatherServiceProtocol {
    
    private let httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol = HttpClient.shared) {
        self.httpClient = httpClient
    }
    
    // MARK: - WeatherServiceProtocol
    
    func info(params: WeatherInfoParams, completionHandler: @escaping WeatherInfoCompletionHandler) {
        let request = WeatherNetworkRouter.info(params: params)
        httpClient.load(request: request, completionHandler: completionHandler)
    }
}
