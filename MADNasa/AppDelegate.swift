//
//  AppDelegate.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appRouter: AppRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        routeToList()
        return true
    }
    
    private func routeToList() {
        let rootViewController = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
       
        appRouter = AppRouter(navigationController: rootViewController)
        appRouter?.route(to: .list)
        
        window?.makeKeyAndVisible()
    }
}
