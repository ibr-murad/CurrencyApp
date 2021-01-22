//
//  UIFont+Ex.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/27/20.
//

import UIKit

extension UIFont {
    
    static func bestFont(forSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let width = UIScreen.main.bounds.width
        let multipliedBy = forSize / width
        let finalSize = forSize * width / 375
        print(finalSize)
        return .systemFont(ofSize: width * multipliedBy, weight: weight)
    }
}
