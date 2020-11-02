//
//  UIView+Ex.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/8/20.
//

import UIKit

extension UIView {
    
    func tapAnimation(complition: @escaping () -> ()) {
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { [weak self] (_)  in
            UIView.animate(withDuration: 0.15) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                complition()
            }
        }
    }
    
    func setGradient(rect: CGRect, colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rect
        gradientLayer.cornerRadius = self.layer.cornerRadius
        var cgColors: [CGColor] = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        gradientLayer.colors = cgColors
        gradientLayer.locations = [0.5, 1]
        gradientLayer.startPoint = .init(x: 0.5, y: 0)
        gradientLayer.endPoint = .init(x: 0.5, y: 1)
        if let gradient = self.layer.sublayers?[0] as? CAGradientLayer {
            gradient.removeFromSuperlayer()
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(color: UIColor, opacity: Float = 1,
                    offSet: CGSize, radius: CGFloat = 1,
                    scale: Bool = true, bounds: CGRect? = nil) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        if let bounds = bounds {
            self.layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: self.layer.cornerRadius).cgPath
        } else {
            self.layer.shadowPath = UIBezierPath(
                roundedRect: self.bounds,
                cornerRadius: self.layer.cornerRadius).cgPath
        }
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
