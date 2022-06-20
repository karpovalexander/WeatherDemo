//
//  Result.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value

        case let .failure(error):
            throw error
        }
    }
}
