//
//  Weather.swift
//  MiniApps
//
//  Created by Василий Тихонов on 06.09.2024.
//

import Foundation

struct Weather: Codable {
    let main: Main
    let weather: [WeatherElement]?
    
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct WeatherElement: Codable {
    let id: Int?
    let description: String?
    let icon: String?
}
