//
//  CurrencyModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/26/20.
//

import Foundation

struct CurrencyModel: Codable, Convertable {
    var name: String
    var full_name: String
    let sell: String
    let buy: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case full_name
        case sell = "sell_value"
        case buy = "buy_value"
    }
    
    func getMultiplier() -> Float {
        if let buy = Float(self.buy) {
            return 1 / buy
        }
        return 0
    }
    
}

protocol Convertable {
    var name: String { get set }
    var full_name: String { get set }
    
    func getMultiplier() -> Float
}
