//
//  BaseViewController.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/7/20.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.addSubviews()
    }
    
    //MARK: - Setters
    
    private func addSubviews() {
        
    }
    
    private func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
}

