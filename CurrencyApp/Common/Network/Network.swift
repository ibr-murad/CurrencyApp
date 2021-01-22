//
//  Network.swift
//  CurrencyApp
//
//  Created by Murodjon Ibrohimovon 10/20/20.
//

import Foundation

class Network {
    
    // MARK: - Variables
    
    static let shared = Network()
    
    private let session = URLSession.init(configuration: .default)
    private let baseURL: String = "https://transfer.humo.tj/currency-app/v1/"
    var baseImageURL: String {
        return self.baseURL + URLPath.get_image.rawValue
    }
    
    // MARK: - Initialization
    
    private init() {}

    // MARK: - Helpers
    
    func request<T: Codable>(url: URLPath, completion: @escaping (Result<T, NetworkError>) -> ()) {
        let fullPath = self.baseURL + url.rawValue
        guard let fullUrl = URL(string: fullPath) else { return }
        let request = URLRequest(url: fullUrl)
        self.session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(.badURL(error)))
                    return
                }
                
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        print(error)
                    }
                    return
                } else {
                    completion(.failure(.parsing))
                    return
                }
                
            }
        }.resume()
    }
    
}
