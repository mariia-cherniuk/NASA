//
//  ItemsListModel.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import Foundation
    
protocol ItemsListInterface {
    func fetch()
}

class ItemsListModel: ItemsListInterface {
    private let remoteListRepository: RemoteListRepository<AstronomyPictureOfTheDay>
    
    init(remoteListRepository: RemoteListRepository<AstronomyPictureOfTheDay>) {
        self.remoteListRepository = remoteListRepository
    }
    
    func fetch() {
        remoteListRepository.fetch(request: ApodRequestBuilder()) { (result) in
            switch result {
            case .failure:
                break
            case .success(let item):
               print(item)
            }
        }
    }
}
