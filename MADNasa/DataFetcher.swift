//
//  DataLoader.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation

protocol DataFetching {
    func loadData(urlRequest: RequestBuilding, completion: @escaping (Result<Data>) -> Void)
}

class DataFetcher: DataFetching {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func loadData(urlRequest: RequestBuilding, completion: @escaping (Result<Data>) -> Void) {
        urlSession.dataTask(with: urlRequest.request()) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(LoadingError.unknown))
            }
        }.resume()
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
    
    init(closure: () throws -> T) {
        do {
            self = .success(try closure())
        } catch {
            self = .failure(error)
        }
    }
}

enum LoadingError: Swift.Error {
    case unknown
}
