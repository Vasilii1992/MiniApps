//
//  CoinServiceError.swift
//  MiniApps
//
//  Created by Василий Тихонов on 06.09.2024.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}
