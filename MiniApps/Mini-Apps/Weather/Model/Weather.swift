
import Foundation

struct GeocodingResponse: Codable {
    let results: [GeocodingResult]
}

struct GeocodingResult: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
}

struct WeatherResponse: Codable {
    let current_weather: CurrentWeather
}

struct CurrentWeather: Codable {
    let temperature: Double
    let weathercode: Int
}

struct Weather {
    let temperature: Double
    let description: String
    let icon: String
    let weatherCode: Int
}
