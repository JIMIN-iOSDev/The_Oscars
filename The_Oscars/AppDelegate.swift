//
//  AppDelegate.swift
//  The_Oscars
//
//  Created by eden on 12/13/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
<<<<<<< HEAD
        window.rootViewController = UINavigationController(rootViewController: ViewController())
//        window.rootViewController = UINavigationController(rootViewController: MovieDetailController())
=======
        window.rootViewController = UINavigationController(rootViewController: TabBarViewController())
>>>>>>> develop
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

