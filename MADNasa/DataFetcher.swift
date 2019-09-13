//
//  DataLoader.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation
import RxSwift

protocol DataFetching {
    func loadData(urlRequest: RequestBuilding) -> Observable<Data>
}

class DataFetcher: DataFetching {
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func loadData(urlRequest: RequestBuilding) -> Observable<Data> {
        return Observable.create { (observer) -> Disposable in
            
            let task = self.urlSession.dataTask(with: urlRequest.request()) { (data, _, error) in
                if let data = data {
                    observer.on(.next(data))
                    observer.on(.completed)
                } else if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.error(LoadingError.unknown))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
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
