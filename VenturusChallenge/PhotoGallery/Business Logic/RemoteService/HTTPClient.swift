//
//  HTTPClient.swift
//  WeatherAppTests
//
//  Created by Marcelo Carvalho on 20/01/23.
//

import Foundation

protocol HTTPClientProtocol {
    func request(url: URL, completion: @escaping (HTTPClient.RequestResult) -> ())
}

final class HTTPClient: HTTPClientProtocol {

    private let session: URLSession

    public typealias RequestResult = Result<Data, HTTPClientError>
    
    public enum HTTPClientError: Error {
        case serverError
        case connectionError
    }
        
    init(session: URLSession) {
        self.session = session
    }
    
    func request(url: URL, completion: @escaping (RequestResult) -> ()) {
        print("REQUEST \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Client-ID 1ceddedc03a5d71",
                                        "content-type": "application/json"]
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in

            DispatchQueue.main.async {                
                if let data = data, error == nil  {
                    completion(.success(data))
                } else {
                    completion(.failure(HTTPClientError.serverError))
                }
            }
        })
        
        task.resume()
    }
}


enum HTTPClientError: Error {
    case noConnection
    case serverError
}



