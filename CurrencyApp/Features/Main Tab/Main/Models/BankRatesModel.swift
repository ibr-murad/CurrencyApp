//
//  BankRatesModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/20/20.
//

import Foundation

struct BankRatesModel: Codable {
    let name: String
    let currency: [CurrencyModel]
    
    private enum CodingKeys: String, CodingKey {
        case name = "bank_name"
        case currency
    }
}
