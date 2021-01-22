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

    private lazy var centerLabel: UILabel = {
        var label = UILabel()
        label.text = "Курс"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        return label
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
        self.centerLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.centerImageView)
        self.view.addSubview(self.centerLabel)
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
