//
//  RoundedView.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/13/20.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    //MARK: - Public variables
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.clipsToBounds = true
    }
    
}
