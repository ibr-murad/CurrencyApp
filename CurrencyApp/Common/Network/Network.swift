//
//  Network.swift
//  CurrencyApp
//
//  Created by Humo Programmer on 10/20/20.
//

import Foundation

class Network {
    
    // MARK: - Variables
    
    static let shared = Network()
    private let session = URLSession.init(configuration: .default)
    private let baseURL: String = "http://192.168.100.46:8220/"
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
        print(fullUrl)
        self.session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(.badURL(error)))
                    return
                }
                
                if let data = data,
                   let result = try? JSONDecoder().decode(T.self, from: data) {
                    //try? CodableStorage.shared.save(result, for: url.rawValue)
                    completion(.success(result))
                    return
                } else {
                    completion(.failure(.parsing))
                    return
                }
                
            }
        }.resume()
    }
    
    func testRequest<T: Codable>(completion: @escaping (Result<T, NetworkError>) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "test", ofType: "json") else { return }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
               let result = try? JSONDecoder().decode(T.self, from: data) {
                //try? CodableStorage.shared.save(result, for: URLPath.all_bank_rates.rawValue)
                completion(.success(result))
            } else {
                completion(.failure(.parsing))
            }
        }
    }
    
    
}
