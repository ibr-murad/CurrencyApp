//
//  NBTRateModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 11/2/20.
//

import Foundation

struct NBTRateModel: Codable {
    let id: String
    let char_code: String
    let nominal: Int
    let name: String
    let value: Float
}
