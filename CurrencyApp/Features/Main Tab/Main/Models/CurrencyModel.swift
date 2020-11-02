//
//  CurrencyModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/26/20.
//

import Foundation

struct CurrencyModel: Codable {
    let name: String
    let sell: String
    let buy: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case sell = "sell_value"
        case buy = "buy_value"
    }
}
