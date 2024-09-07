//
//  Coin.swift
//  MiniApps
//
//  Created by Василий Тихонов on 06.09.2024.
//

import Foundation

struct CoinArray: Decodable {
    let data: [Coin]
}

struct Coin: Codable {
    let id: Int
    let name: String
    let pricingData: PricingData
    
    var logoURL: URL? {
        return URL(string: "https://s2.coinmarketcap.com/static/img/coins/200x200/\(id).png")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case pricingData = "quote"
    }
}

struct PricingData: Codable {
    let USD: USD
}

struct USD: Codable {
    let price: Double
}
