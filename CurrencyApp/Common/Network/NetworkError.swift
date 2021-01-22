//
//  NetworkError.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/20/20.
//

import Foundation

enum NetworkError: Error {
    case badURL(Error)
    case parsing
    case unowned
}
