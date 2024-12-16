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
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginViewController() // 초기 ViewController 설정
        window?.makeKeyAndVisible()
        return true
    }
}


