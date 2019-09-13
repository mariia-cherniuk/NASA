//
//  ListRepository.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation
import RxSwift

protocol ListRepository {
    associatedtype T
    
    func fetch(request: RequestBuilding, completion: @escaping (Result<T>) -> Void)
}

final class RemoteListRepository<T: Decodable>: ListRepository {
    private let bag = DisposeBag()
    private let fetcher: DataFetching
    
    init(fetcher: DataFetching) {
        self.fetcher = fetcher
    }
    
    func fetch(request: RequestBuilding, completion: @escaping (Result<T>) -> Void) {
        let observable = fetcher.loadData(urlRequest: request)
        
        observable.subscribe(onNext: { (data) in
            let result = Result(closure: { () -> T in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
            })
            completion(result)
        }, onError: { (error) in
            completion(Result.failure(error))
        }).disposed(by: bag)
    }
}
