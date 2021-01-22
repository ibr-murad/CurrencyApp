//
//  SplashViewController.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/7/20.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    //MARK: - GUI variables
    
    private lazy var centerImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "launch")
        return imageView
    }()

    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.addSubviews()
        self.makeConstraints()
        self.makeServiceCall()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.centerImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.centerImageView)
    }
    
    //MARK: - Helpers
    
    private func makeServiceCall() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            if UserDefaults.standard.doesUserPassInitialSetup() {
                AppDelegate.shared.rootViewController.showTabBarController()
            } else {
                AppDelegate.shared.rootViewController.showOnboardingController()
            }
        }
    }
    
}
