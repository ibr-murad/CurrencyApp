//
//  UIViewController+Ex.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/23/20.
//

import UIKit

extension UIViewController {
    
    // MARK: - Keyboard
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}
