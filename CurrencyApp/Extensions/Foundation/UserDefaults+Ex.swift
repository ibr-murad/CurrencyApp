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
    
}
