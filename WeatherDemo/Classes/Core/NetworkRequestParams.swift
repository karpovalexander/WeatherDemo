//
//  NetworkRequestParams.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Alamofire

protocol NetworkRequestParams {
    var baseUrlPath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension NetworkRequestParams {
    
    var encoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    var headers: HTTPHeaders? {
        var headers = HTTPHeaders()
        
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "Accept", value: "application/json")

        return headers
    }
    
    var parameters: Parameters? {
        return nil
    }
}

extension URLRequestConvertible where Self: NetworkRequestParams  {
    
    func asURLRequest() throws -> URLRequest {
        guard let baseUrl = URL(string: baseUrlPath) else { fatalError("baseURL could not be configured.") }
        let url = baseUrl.appendingPathComponent(self.path)
        var request = try! URLRequest(url: url, method: self.method, headers: self.headers)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 60
        return try self.encoding.encode(request, with: self.parameters)
    }
}
