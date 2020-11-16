//
//  NBTRateModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 11/2/20.
//

import Foundation

struct NBTRateModel: Codable, Convertable {
    let id: String
    var name: String
    let nominal: Int
    let flag: String
    var full_name: String
    let value: Float
    
    func getMultiplier() -> Float {
        return Float(self.nominal) / self.value
    }
}
