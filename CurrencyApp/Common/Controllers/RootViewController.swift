//
//  RootViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/7/20.
//

import UIKit

class RootViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.isBlackStatusBar {
            return .default
        }
        return .lightContent
    }
    
    // MARK: - Private variables
    
    var isBlackStatusBar: Bool = true {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    private var current: UIViewController
    
    // MARK: - Initialization
    
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("RootViewController init coder error")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupController()
    }
    
    // MARK: - Setters
    
    private func setupController() {
        self.view.backgroundColor = .white
        self.addChild(current)
        self.current.view.frame = view.bounds
        self.view.addSubview(current.view)
        self.current.didMove(toParent: self)
    }
    
    // MARK: - Helpers
    
    func showTabBarController() {
        let tabController = Interface.shared.tabBarController
        self.animateFadeTransition(to: tabController)
    }
    
    func showOnboardingController() {
        let onboardingController = OnboardingPageViewController(
            transitionStyle: .scroll, navigationOrientation: .horizontal)
        self.animateFadeTransition(to: onboardingController)
    }
    
    
    // MARK: - Animations
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        self.current.willMove(toParent: nil)
        self.addChild(new)
        self.transition(from: self.current, to: new, duration: 0.5,
                        options: [.transitionCrossDissolve, .curveEaseOut],
                        animations: nil) { _ in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
}
