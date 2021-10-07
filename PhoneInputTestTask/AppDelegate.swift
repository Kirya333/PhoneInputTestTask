//
//  AppDelegate.swift
//  PhoneInputTestTask
//
//  Created by Кирилл Тарасов on 29.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = WelcomeScreenViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

    
}

