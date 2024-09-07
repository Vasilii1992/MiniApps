//
//  CoinService.swift
//  MiniApps
//
//  Created by Василий Тихонов on 06.09.2024.
//

import Foundation

final class CoinService {
    
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinServiceError>) -> Void) {
        
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
                return
            }
            
            if let responce = responce as? HTTPURLResponse, responce.statusCode != 200 {
                do {
                    let coinError = try JSONDecoder().decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(coinError)))
                    
                } catch let error {
                    completion(.failure(.unknown()))
                    print(error.localizedDescription)
                    
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    completion(.success(coinData.data))
                    
                } catch let error {
                    completion(.failure(.decodingError()))
                    print(error.localizedDescription)
                }
            } else {
                completion(.failure(.unknown()))
            }
        }.resume()
    }
}
