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
        let defaultCurrencyName = self.type == .type1 ? Settings.shared.defaultCurrency.rawValue : "RUB"
        let best = self.banks.max {  (i, j) -> Bool in
            if let iCurrency = i.currency.first(where: { return $0.name == defaultCurrencyName }),
               let jCurrency = j.currency.first(where: { return $0.name == defaultCurrencyName }),
               let iBuy = Double(iCurrency.buy),
               let jBuy = Double(jCurrency.buy) {
                return iBuy < jBuy
            } else {
                return false
            }
        }
        guard let bestBank = best,
              let indexOfBestBank = self.banks
                .firstIndex(where: {$0.name == bestBank.name}) else {
            self.bestBank = self.banks.first
            return
        }
        
        self.bestBank = best
        self.banks.remove(at: indexOfBestBank)
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
