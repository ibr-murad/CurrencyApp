//
//  Network.swift
//  CurrencyApp
//
//  Created by Humo Programmer  on 10/20/20.
//

import Foundation

class Network {
    
    // MARK: - Public variables
    
    static let shared = Network()
    
    // MARK: - Private variables
    
    private var session = URLSession.init(configuration: .default)
    private let baseUrl: String = "https://jsonplaceholder.typicode.com/todos"

    // MARK: - Initialization
    
    private init() {}

    // MARK: - Helpers
    
    func request<T: Codable>(url: String,
                 params: [String: String]? = nil,
                 completion: @escaping (Result<T, NetworkError>) -> ()) {
        
        guard let url = URL(string: self.baseUrl) else { return }
        let request = URLRequest(url: url)
        self.session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(.badURL(error)))
                }
                
                if let data = data,
                   let result = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(.parsing))
                }
                
            }
        }.resume()
    }
    
}
