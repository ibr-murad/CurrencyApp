//
//  UIScrollView+Ex.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/3/20.
//

import UIKit

extension UIScrollView {
    
    var isAtTop: Bool {
        return self.contentOffset.y <= self.verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return self.contentOffset.y >= self.verticalOffsetForBottom
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = self.contentInset.top
        return topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = self.bounds.height
        let scrollContentSizeHeight = self.contentSize.height
        let bottomInset = self.contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
    
}
