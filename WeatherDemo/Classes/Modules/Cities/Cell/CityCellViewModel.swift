//
//  CityCellViewModel.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

struct CityCellViewModel {
    let imageURL: URL?
    let title: String
    let city: City
    
    init(imageURL: URL?, city: City) {
        self.city = city
        self.imageURL = imageURL
        self.title = city.name
    }
}
