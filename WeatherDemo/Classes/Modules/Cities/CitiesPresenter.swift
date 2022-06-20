//
//  CitiesPresenter.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

protocol CitiesPresenterProtocol {
    func loadData()
    func search(_ searchText: String)
    func cityDidSelect(item: CityCellViewModel)
    
    var viewModels: [CityCellViewModel] { get }
}

final class CitiesPresenter: CitiesPresenterProtocol {
    
    private enum Constant {
        static let searchTextMinLength = 3
        static let searchResultMaxCount = 20
        static let imageURL1 = URL(string: "https://infotech.gov.ua/storage/img/Temp3.png")
        static let imageURL2 = URL(string: "https://infotech.gov.ua/storage/img/Temp1.png")
    }
    
    private weak var view: CitiesViewProtocol?
    private let router: CitiesRouterProtocol
    private let cityService: CityServiceProtocol
    private var allViewModels: [CityCellViewModel] = []
    private var previousStateIsSearch: Bool = false
    
    init(view: CitiesViewProtocol,
         router: CitiesRouterProtocol,
         cityService: CityServiceProtocol = CityService()) {
        self.view = view
        self.router = router
        self.cityService = cityService
    }
    
    // MARK: - CitiesPresenterProtocol
    
    var viewModels: [CityCellViewModel] = []
    
    func loadData() {
        view?.updateLoaderState(isLoading: true)
        cityService.list { [weak self] result in
            guard let `self` = self else { return }
            self.view?.updateLoaderState(isLoading: false)
            switch result {
            case let .success(cities):
                self.configureViewModels(for: cities)
                
            case let .failure(error):
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func search(_ searchText: String) {
        guard !allViewModels.isEmpty else {
            return
        }
        
        let searchIsActive = !searchText.isEmpty && searchText.count >= Constant.searchTextMinLength
        
        guard searchIsActive || (!searchIsActive && previousStateIsSearch) else {
            return
        }
        viewModels = !searchIsActive ? allViewModels : Array(allViewModels.filter({
            $0.city.name.lowercased().contains(searchText.lowercased())
        }).prefix(Constant.searchResultMaxCount))
        previousStateIsSearch = searchIsActive
        view?.reload()
    }
    
    func cityDidSelect(item: CityCellViewModel) {
        router.showWeather(for: item.city)
    }
    
    // MARK: - Private
    
    private func configureViewModels(for cities: [City]) {
        viewModels = cities.enumerated().map({
            let imageURL = $0.offset % 2 == 0 ? Constant.imageURL1 : Constant.imageURL2
            return .init(imageURL: imageURL, city: $0.element)
        })
        allViewModels = viewModels
        
        view?.reload()
    }
}
