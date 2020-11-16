//
//  SplashViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/7/20.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    //MARK: - GUI variables
    
    private lazy var centerImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "launch")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var centerLabel: UILabel = {
        var label = UILabel()
        label.text = "Курс"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.style = .whiteLarge
        view.color = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.centerImageView)
        self.view.addSubview(self.centerLabel)
        self.view.addSubview(self.activityIndicator)
    }
    
    //MARK: - Helpers
    
    private func makeServiceCall() {
        self.activityIndicatorViewAnimate(indicator: self.activityIndicator)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.activityIndicator.stopAnimating()
            
            if UserDefaults.standard.doesUserPassInitialSetup() {
                AppDelegate.shared.rootViewController.showTabBarController()
            } else {
                AppDelegate.shared.rootViewController.showOnboardingController()
            }
        }
    }
    
    //MARK: - Animations
    
    private func activityIndicatorViewAnimate(indicator: UIActivityIndicatorView) {
        indicator.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 0.5) {
            indicator.transform = .identity
        }
        indicator.alpha = 0
        UIView.animate(withDuration: 0.2, animations: {
            indicator.alpha = 1
        }) { (finished) in
            indicator.startAnimating()
        }
    }
    
}
