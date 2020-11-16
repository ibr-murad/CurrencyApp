//
//  Interface.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/8/20.
//

import UIKit

class Interface {
    
    // MARK: - Public variables
    
    static let shared = Interface()
    weak var window: UIWindow?

    // MARK: - GUI variables
    
    lazy var tabBarController = TabBarController()

    // MARK: - Initialization
    
    private init() {}

    // MARK: - Helpers
    
    func pushVC(vc: UIViewController) {
        (self.tabBarController.selectedViewController as? UINavigationController)?
            .pushViewController(vc, animated: true)
    }

    func popVC(to vc: UIViewController? = nil) {
        if let vc = vc {
            (self.tabBarController.selectedViewController as? UINavigationController)?
                .popToViewController(vc, animated: true)
        } else {
            (self.tabBarController.selectedViewController as? UINavigationController)?
                .popViewController(animated: true)
        }
    }
    
}
