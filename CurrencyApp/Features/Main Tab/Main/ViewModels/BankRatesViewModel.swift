//
//  BankRatesViewModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/26/20.
//

import UIKit

struct BankRatesViewModel {
    let name: String
    let currency: [CurrencyModel]
    var logoImage: UIImage? {
        return UIImage(named: self.name)
    }
    
    init(model: BankRatesModel) {
        self.name = model.name
        self.currency = model.currency
    }
}

