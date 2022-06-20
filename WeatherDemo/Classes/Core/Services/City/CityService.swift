//
//  CityService.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

typealias CitiesListCompletionHandler = (Result<[City]>) -> Void

protocol CityServiceProtocol {
    func list(completionHandler: @escaping CitiesListCompletionHandler)
}

final class CityService: CityServiceProtocol {
    
    private enum Constants {
        enum CityList {
            static let fileName = "city_list"
            static let fileExtension = "json"
        }
    }
    
    private let mapper: MapperProtocol
    
    init(mapper: MapperProtocol = Mapper()) {
        self.mapper = mapper
    }
    
    // MARK: - CityServiceProtocol
    
    func list(completionHandler: @escaping CitiesListCompletionHandler) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self,
                    let url = Bundle.main.url(forResource: Constants.CityList.fileName,
                                            withExtension: Constants.CityList.fileExtension) else {
                
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let result: Result<[City]> = self.mapper.map(data: data)
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(.parsing))
                }
            }
        }
    }
}
