//
//  APICaller.swift
//  ImageLoader
//
//  Created by Mac mini on 06/04/23.
//

import Foundation
final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let productURL = URL(string: "https://test.dev-fsit.com/api/image-list")
    }
    
    private init() {}
    
    public func getJsonResult(completion: @escaping (Result<[MainDataSource], Error>) -> Void) {
        guard let url = Constants.productURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(ProductsModel.self, from: data)
                    print("Data: \(result.data)")
                    completion(.success(result.data!))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
    }
    
}
