//
//  SeconViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/9/20.
//

import UIKit

class SecondViewController: BaseViewController {
    
    //MARK: - Public variables
    
    //MARK: - Private variables
    
    //MARK: - GUI variables
    
    private lazy var main: UIView = {
        var view = UIView()
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let color1 = UIColor(rgb: 0xDE5000, alpha: 1).cgColor
        let color2 = UIColor(rgb: 0xFC8D26, alpha: 1).cgColor
        gradientLayer.colors = [color1, color2]
        
        
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.makeConstraints()
    }
    
    //MARK: - Constraints
    
    private func makeConstraints() {
        self.main.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        self.view.addSubview(self.main)
    }
    
}

