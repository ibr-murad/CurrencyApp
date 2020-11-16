//
//  AppColors.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/8/20.
//

import UIKit

enum Colors {
    
    //MARK: - Text color
    
    case textBlackMain
    case textBlackHight
    case textBlackMiddle
    case textBlackDisabled
    
    func color() -> UIColor {
        switch self {
        case .textBlackMain:
            return .init(rgb: 0x000000, alpha: 1)
        case .textBlackHight:
            return .init(rgb: 0x000000, alpha: 0.87)
        case .textBlackMiddle:
            return .init(rgb: 0x000000, alpha: 0.60)
        case .textBlackDisabled:
            return .init(rgb: 0x000000, alpha: 0.36)
        }
    }
}
