//
//  BankRatesModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/20/20.
//

import Foundation

struct BankRatesModel: Codable {
    let name: String
    let colors: ColorsModel
    let icon: String
    let isColored: Bool
    let appStoreLink: String
    let currency: [CurrencyModel]
    
    private enum CodingKeys: String, CodingKey {
        case name = "bank_name"
        case colors
        case icon
        case isColored = "is_change"
        case appStoreLink = "ios_link"
        case currency
    }
    
}
