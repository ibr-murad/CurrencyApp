//
//  BankRatesModel.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/20/20.
//

import UIKit
import Kingfisher

struct BankRatesModel: Codable {
    let name: String
    let colors: ColorsModel
    let icon: String
    let isColored: Bool
    let appStoreLink: String
    let currency: [CurrencyModel]
    
    private enum CodingKeys: String, CodingKey {
        case name = "bank_name"
        case colors
        case icon
        case isColored = "is_change"
        case appStoreLink = "ios_link"
        case currency = "Currency"
    }
    
    func getImage(completion: @escaping (UIImage) -> Void) {
        if let url = URL(string: self.icon) {
            KingfisherManager.shared.retrieveImage(with: url) { (result) in
                switch result {
                case .success(let value):
                    if self.isColored {
                        completion(value.image.with(color: .white))
                    } else {
                        completion(value.image)
                    }
                    return
                case .failure(let error):
                    print(error)
                    return
                }
            }
        }
    }
    
}
