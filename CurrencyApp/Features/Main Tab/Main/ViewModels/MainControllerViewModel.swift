//
//  MainControllerViewModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/28/20.
//

import UIKit

enum MainDataType: String {
    case type1
    case type2
}

struct MainControllerViewModel {
    
    var bestBank: BankRatesModel?
    private (set) var type: MainDataType = .type1
    var banks: [BankRatesModel] = []
    
    init() {}
    
    init(models: [BankRatesModel], type: MainDataType = .type1) {
        for model in models {
            self.banks.append(model)
        }
        self.type = type
        self.culculateBestRate()
    }
    
    private mutating func culculateBestRate() {
        guard self.banks.count > 0 else { return }
        self.bestBank = self.banks[0]
        var bestBuy: Float = 0
        for i in 0..<self.banks.count {
            for j in 0..<self.banks[i].currency.count {
                let defaultCurrencyName = self.type == .type1 ? Settings.shared.defaultCurrency.rawValue : "RUB"
                if self.banks[i].currency[j].name == defaultCurrencyName {
                    if let buy = Float(self.banks[i].currency[j].buy) {
                        if buy > bestBuy {
                            bestBuy = buy
                            self.bestBank = self.banks[i]
                        }
                    }
                }
            }
        }
    }
    
}

struct MainControllerViewModel1 {
    
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
                if self.banks[i].currency[j].name == "RUB" {
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
