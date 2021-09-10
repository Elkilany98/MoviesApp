//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable  = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        window = UIWindow(frame: UIScreen.main.bounds)
        let splashVC = SplashVC()
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
        
        return true
    }


}

