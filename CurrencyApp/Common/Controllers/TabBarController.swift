//
//  TabBarController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/8/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - GUI variables
    
    private lazy var mainTab: MainViewController = {
        let controller = MainViewController()
        controller.tabBarItem = UITabBarItem(
            title: "Выгодный курс",
            image: UIImage(named: "share"), tag: 0)
        return controller
    }()

    private lazy var categoryTab: SecondViewController = {
        let controller = SecondViewController()
        controller.view.backgroundColor = .blue
        controller.tabBarItem = UITabBarItem(
            title: "НБТ",
            image: UIImage(named: "share"), tag: 1)
        return controller
    }()

    private lazy var searchTab: BaseViewController = {
        let controller = BaseViewController()
        controller.view.backgroundColor = .red
        controller.tabBarItem = UITabBarItem(
            title: "Обмен валют",
            image: UIImage(named: "share"), tag: 2)
        return controller
    }()

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabs = [self.mainTab, self.categoryTab, self.searchTab]
        self.viewControllers = tabs.map { UINavigationController(rootViewController: $0)}
        self.tabBarStyle()
    }

    // MARK: - Setters
    
    private func tabBarStyle() {
        self.tabBar.tintColor = .black
        self.tabBar.barTintColor = .white
    }
    
}
