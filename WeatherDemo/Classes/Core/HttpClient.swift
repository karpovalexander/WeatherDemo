//
//  HttpClient.swift
//  WeatherDemo
//
//  Created by AndUser on 19.06.2022.
//

import Alamofire

protocol HttpClientProtocol {
    
    func load<T: Decodable>(request: NetworkRequestParams & URLRequestConvertible,
                            rootKey: String?,
                            completionHandler: @escaping (_ result: Result<T>) -> Void)
}

extension HttpClientProtocol {
    
    func load<T: Decodable>(request: NetworkRequestParams & URLRequestConvertible,
                            rootKey: String?,
                            completionHandler: @escaping (_ result: Result<T>) -> Void) {
        load(request: request, rootKey: rootKey, completionHandler: completionHandler)
    }
    
    func load<T: Decodable>(request: NetworkRequestParams & URLRequestConvertible,
                            completionHandler: @escaping (_ result: Result<T>) -> Void) {
        load(request: request, rootKey: nil, completionHandler: completionHandler)
    }
}

final class HttpClient: HttpClientProtocol {
    
    private let sessionManager: Alamofire.Session
    private let mapper: MapperProtocol
    
    static let shared = HttpClient()
    
    private init(mapper: MapperProtocol = Mapper()) {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 1
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForResource = 60
        
        self.sessionManager = Session(configuration: configuration)
        self.mapper = mapper
    }
    
    deinit {
        sessionManager.session.getAllTasks { (task) in
            task.forEach { $0.cancel() }
        }
    }
    
    // MARK: - HttpClientProtocol
    
    func load<T: Decodable>(request: NetworkRequestParams & URLRequestConvertible,
                            rootKey: String?,
                            completionHandler: @escaping (_ result: Result<T>) -> Void) {
        
        sendRequest(request: request, rootKey: rootKey) { (response) in
            switch response {
            case let .success(data):
                let mapperResult: Result<T> = self.mapper.map(data: data, rootKey: rootKey)
                completionHandler(mapperResult)
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // MARK: - Private
    
    private func sendRequest(request: NetworkRequestParams & URLRequestConvertible,
                             rootKey: String?,
                             completionHandler: @escaping (_ result: Result<Data>) -> Void) {
        
        let urlRequest = try! request.asURLRequest()
        print(urlRequest)
        sessionManager.request(urlRequest).responseData(queue: DispatchQueue.global(qos: .utility)) { (response) in
            DispatchQueue.main.async {
                self.handle(response: response, rootKey: rootKey, completionHandler: completionHandler)
            }
        }
    }
    
    private func handle(response: AFDataResponse<Data>, rootKey: String?, completionHandler: @escaping (_ result: Result<Data>) -> Void) {
        
        if let error = response.error {
            if error.responseCode == NSURLErrorNotConnectedToInternet {
                completionHandler(.failure(Error.noConnection))
                return
            }
            completionHandler(.failure(Error.timeout))
            return
        }
        
        guard let httpResponse = response.response else {
            completionHandler(.failure(Error.parsing))
            return
        }
        
        switch httpResponse.statusCode {
        case 200...205:
            guard let data = response.data else {
                completionHandler(.failure(Error.parsing))
                return
            }
            completionHandler(.success(data))
            
        case 400..<600:
            let error = Error.somethingWentWrong
            completionHandler(.failure(error))
            
        default:
            break
        }
    }
}
