//
//  Settings.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/26/20.
//

import UIKit

class Settings {
    
    static let shared = Settings()
    
    //MARK: - Public variables
    
    var currentCurrencyName: String {
        get {
            return UserDefaults.standard.getCurrentCurrencyName()
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentCurrencyName")
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
    
    enum Mode {
        case plain
        case extend
    }
    
    //MARK: - Initialization
    
    private init() {}
    
    //MARK: - Helpers
    
}
