//
//  Mapper.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Foundation

protocol MapperProtocol {
    func map<T: Decodable>(json: [String: Any],
                           dateDecodingStrategy: JSONDecoder.DateDecodingStrategy,
                           rootKey: String?) -> Result<T>
    
    func map<T: Decodable>(data: Data,
                           dateDecodingStrategy: JSONDecoder.DateDecodingStrategy,
                           rootKey: String?) -> Result<T>
}

extension MapperProtocol {
    
    func map<T: Decodable>(json: [String: Any]) -> Result<T> {
        map(json: json, dateDecodingStrategy: .deferredToDate, rootKey: nil)
    }
    
    func map<T: Decodable>(data: Data, rootKey: String? = nil) -> Result<T> {
        map(data: data, dateDecodingStrategy: .deferredToDate, rootKey: rootKey)
    }
}

final class Mapper : MapperProtocol {
    
    func map<T>(data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy, rootKey: String?) -> Result<T> where T : Decodable {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        do {
            if let key = rootKey {
                let result = try decoder.decode(T.self, from: data, keyPath: key)
                return .success(result)
            } else {
                let result = try decoder.decode(T.self, from: data)
                return .success(result)
            }
        } catch DecodingError.dataCorrupted(let context) {
            print(DecodingError.dataCorrupted(context))
            return .failure(Error.parsing)
        } catch DecodingError.keyNotFound(let key, let context) {
            print(DecodingError.keyNotFound(key, context))
            return .failure(Error.parsing)
        } catch DecodingError.typeMismatch(let type, let context) {
            print(DecodingError.typeMismatch(type, context))
            return .failure(Error.parsing)
        } catch DecodingError.valueNotFound(let value, let context) {
            print(DecodingError.valueNotFound(value, context))
            return .failure(Error.parsing)
        } catch let error {
            print(error)
            return .failure(Error.parsing)
        }
    }
    
    func map<T: Decodable>(json: [String: Any], dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, rootKey: String?) -> Result<T> {
        if let key = rootKey, json[key] is NSNull {
            return .failure(Error.parsing)
        }
        let _json = (rootKey != nil) ? json[rootKey!] as Any? : json
        guard _json != nil else {
            return .failure(Error.parsing)
        }
        guard let jsonObject = _json else {
            return .failure(Error.parsing)
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: [])
        guard let parsedData = data else { return .failure(Error.parsing) }
        return map(data: parsedData, dateDecodingStrategy: dateDecodingStrategy, rootKey: nil)
    }
}
