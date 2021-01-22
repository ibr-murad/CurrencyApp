//
//  Settings.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/26/20.
//

import UIKit

class Settings {
    
    static let shared = Settings()
    
    //MARK: - Public variables
    
    var defaultCurrency: DefaultCurrency {
        get {
            return UserDefaults.standard.getDefaultCurrencyName()
        } set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: "defaultCurrencyName")
        }
    }
    
    var mode: Mode {
        get {
            if UserDefaults.standard.isPlainMode() {
                return .plain
            }
            return .extend
        }
        set {
            if newValue == .plain {
                UserDefaults.standard.set(true, forKey: "isPlainMode")
            } else {
                UserDefaults.standard.set(false, forKey: "isPlainMode")
            }
        }
    }
    
    enum Mode: String {
        case plain = "Простой"
        case extend = "Расширенный"
    }
    

    
    //MARK: - Initialization
    
    private init() {}
    
    //MARK: - Helpers
    
}

enum DefaultCurrency: String {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    case tjs = "TJS"
}
