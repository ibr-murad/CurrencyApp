//
//  UserDefaults+Ex.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/14/20.
//

import Foundation

extension UserDefaults {
    
    func doesUserPassInitialSetup() -> Bool {
        return bool(forKey: "doesUserPassInitialSetup")
    }
    
    func isPlainMode() -> Bool {
        return bool(forKey: "isPlainMode")
    }
    
    func getDefaultCurrencyName() -> DefaultCurrency {
        if let name = value(forKey: "defaultCurrencyName") as? String,
           let rawValue = DefaultCurrency(rawValue: name) {
            return rawValue
        }
        return .rub
    }
    
    func saveLastUpdate() {
        let current = Date()
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.YYYY HH:mm"
        setValue(formater.string(from: current), forKey: "lastUpdate")
        synchronize()
    }
    
    var lastUpdated: String {
        guard let string = value(forKey: "lastUpdate") as? String else {
            
            return Date().description
        }
        return string
    }
    
}
