//
//  ListRepository.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation

protocol ListRepository {
    associatedtype T
    
    func fetch(request: RequestBuilding, completion: @escaping (Result<T>) -> Void)
}

final class RemoteListRepository<T: Decodable>: ListRepository {
    let fetcher: DataFetching
    
    init(fetcher: DataFetching) {
        self.fetcher = fetcher
    }
    
    func fetch(request: RequestBuilding, completion: @escaping (Result<T>) -> Void) {
        fetcher.loadData(urlRequest: request) { (result) in
            switch result {
            case .failure(let error):
                completion(Result.failure(error))
            case .success(let data):
                let result = Result(closure: { () -> T in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return try decoder.decode(T.self, from: data)
                })
                
                completion(result)
            }
        }
    }
}
