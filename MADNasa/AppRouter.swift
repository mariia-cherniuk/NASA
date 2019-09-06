//
//  AppRouter.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import UIKit

protocol AppRouting {
    func route(to appFlow: AppRouter.Route)
}

class AppRouter: AppRouting {
    enum Route {
        case list
        case details
    }
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func route(to appFlow: Route) {
        switch appFlow {
        case .list:
            routToList()
         case .details:
            break
        }
    }
}

// MARK: - Private
extension AppRouter {
    func routToList() {
        let model = ItemsListModel(remoteListRepository: RemoteListRepository(fetcher: DataFetcher(urlSession: URLSession.shared)))
        let listViewController = ListViewController(model: model)
        navigationController.pushViewController(listViewController, animated: false)
    }
}
