//
//  Error.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

enum Error : Swift.Error, LocalizedError {

    case parsing
    case noConnection
    case timeout
    case somethingWentWrong
    
    var errorDescription: String? {
        switch self {
        case .parsing:
            return L10n.Error.parsing
            
        case .noConnection:
            return "Internet conenction is missing"
            
        case .timeout:
            return "Timeout"
            
        case .somethingWentWrong:
            return "Something went wrong"
        }
    }
}
