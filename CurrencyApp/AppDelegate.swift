//
//  AppDelegate.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/7/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { return false }
        
        if #available(iOS 13.0, *) {
            window.overrideUserInterfaceStyle = .light
        }
        window.rootViewController = RootViewController()
        window.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: RootViewController {
        return self.window!.rootViewController as! RootViewController
    }
}
