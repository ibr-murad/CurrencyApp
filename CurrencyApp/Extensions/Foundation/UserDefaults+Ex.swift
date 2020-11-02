//
//  UserDefaults+Ex.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/14/20.
//

import Foundation

extension UserDefaults {
    
    func doesUserPassInitialSetup() -> Bool {
        return bool(forKey: "doesUserPassInitialSetup")
    }
    
    func isPlainMode() -> Bool {
        return bool(forKey: "isPlainMode")
    }
    
    func getCurrentCurrencyName() -> String {
        if let name = value(forKey: "currentCurrencyName") as? String {
            return name
        }
        return "RUB"
    }
    
    func setCurrentTopColorModel(model: CurrentTopColorModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            set(encoded, forKey: "CurrentTopColorModel")
        }
        synchronize()
    }
    
    func getCurrentTopColorModel() -> CurrentTopColorModel {
        let decoder = JSONDecoder()
        if let saved = object(forKey: "CurrentTopColorModel") as? Data,
           let model = try? decoder.decode(CurrentTopColorModel.self, from: saved) {
            return model
        }
        return CurrentTopColorModel(
            gradientColors: [0xDE5000, 0xFC8D26],
            shadowColor: 0xFB8B25)
    }
    
}
