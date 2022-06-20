//
//  CitiesRouter.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

protocol CitiesRouterProtocol {
    func showWeather(for city: City)
}

final class CitiesRouter: BaseRouter, CitiesRouterProtocol {
    
    func showWeather(for city: City) {
        let vc = WeatherViewController.controller(city: city)
        sourceViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
