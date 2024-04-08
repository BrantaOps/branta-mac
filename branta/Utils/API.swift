//
//  API.swift
//  Branta
//
//  Created by Keith Gardner on 4/7/24.
//


import Foundation

enum APIError: Error {
    case NoInternetConnection
    case RequestFailed
}

class API {
    class func send(url: URL, method: String = "GET", body: Data? = nil, completion: @escaping (Result<Data, APIError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                if let error = error as? URLError, error.code == .notConnectedToInternet {
                    completion(.failure(.NoInternetConnection))
                } else {
                    completion(.failure(.RequestFailed))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.RequestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.RequestFailed))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}
