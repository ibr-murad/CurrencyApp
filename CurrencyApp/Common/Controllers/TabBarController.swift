//
//  TabBarController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/8/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - GUI variables
    
    private lazy var mainTab: MainViewController = {
        let controller = MainViewController()
        controller.tabBarItem = UITabBarItem(
            title: "Выгодный курс",
            image: UIImage(named: "tab-1"), tag: 0)
        return controller
    }()

    private lazy var nbtTab: NBTViewController = {
        let controller = NBTViewController()
        controller.tabBarItem = UITabBarItem(
            title: "Курсы от НБТ",
            image: UIImage(named: "tab-2"), tag: 1)
        return controller
    }()

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabs = [self.mainTab, self.nbtTab]
        self.viewControllers = tabs.map { UINavigationController(rootViewController: $0)}
        self.tabBarStyle()
    }

    // MARK: - Setters
    
    private func tabBarStyle() {
        self.tabBar.tintColor = UIColor(hex: "#158C62")
        self.tabBar.barTintColor = .white
    }
    
}
