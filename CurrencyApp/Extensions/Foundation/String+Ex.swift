//
//  String+Ex.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimov on 11/13/20.
//

import Foundation

extension String {
    
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }

}
