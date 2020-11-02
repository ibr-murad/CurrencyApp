//
//  MainControllerViewModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/28/20.
//

import UIKit

struct MainControllerViewModel {
    
    var bestBank: BankRatesViewModel?
    var banks: [BankRatesViewModel] = []
    
    
    init() {}
    
    init(models: [BankRatesModel]) {
        for model in models {
            self.banks.append(.init(model: model))
        }
        self.culculateBestRate()
    }
    
    private mutating func culculateBestRate() {
        guard self.banks.count > 0 else { return }
        self.bestBank = self.banks[0]
        var bestSell: Float = 0
        for i in 0..<self.banks.count {
            for j in 0..<self.banks[i].currency.count {
                if self.banks[i].currency[j].name == Settings.shared.currentCurrencyName {
                    if let sell = Float(self.banks[i].currency[j].sell) {
                        if sell > bestSell {
                            bestSell = sell
                            self.bestBank = self.banks[i]
                        }
                    }
                }
            }
        }
    }
    
}
