//
//  WeatherPresenter.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

protocol WeatherPresenterProtocol {
    func loadData()
    
    var title: String { get }
    var viewModels: [WeatherInfoCellViewModel] { get }
}

final class WeatherPresenter: WeatherPresenterProtocol {
    
    private weak var view: WeatherViewProtocol?
    private let weatherService: WeatherServiceProtocol
    private let city: City
    
    init(city: City,
         view: WeatherViewProtocol,
         weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
        self.city = city
        self.view = view
    }
    
    // MARK: - WeatherPresenterProtocol
    
    var title: String {
        city.name
    }
    var viewModels: [WeatherInfoCellViewModel] = []
    
    func loadData() {
        view?.focusMap(at: city.coordinate)
        
        let params = WeatherInfoParams(coordinate: city.coordinate)
        weatherService.info(params: params) { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case let .success(info):
                self.configureViewModels(for: info)
                
            case let .failure(error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private
    
    private func configureViewModels(for item: Weather) {
        viewModels = [
            .init(title: L10n.WeatherInfo.description, value: item.description),
            .init(title: L10n.WeatherInfo.currentTemperature, value: item.dispayCurrentTemperature),
            .init(title: L10n.WeatherInfo.minTemperature, value: item.displayMinimumTemperature),
            .init(title: L10n.WeatherInfo.maxTemperature, value: item.displayMaximumTemperature),
            .init(title: L10n.WeatherInfo.humidity, value: item.displayHumidity),
            .init(title: L10n.WeatherInfo.windSpeed, value: item.displaySpeed)
        ]
        view?.reload()
    }
}
