
import Foundation


final class APIManager {
    
    private let geocodingBaseURL = "https://geocoding-api.open-meteo.com/v1/search"
    private let weatherBaseURL = "https://api.open-meteo.com/v1/forecast"
    
    func geocode(city: String, completion: @escaping (GeocodingResult?, WeatherError?) -> Void) {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(geocodingBaseURL)?name=\(cityEncoded)&count=1&language=ru&format=json"
        
        guard let url = URL(string: urlString) else {
            completion(nil, .invalidCity)
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: 15)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, .networkError(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, .cityNotFound)
                return
            }
            
            guard let data = data else {
                completion(nil, .decodingError)
                return
            }
            
            do {
                let geocodingResponse = try JSONDecoder().decode(GeocodingResponse.self, from: data)
                if let firstResult = geocodingResponse.results.first {
                    completion(firstResult, nil)
                } else {
                    completion(nil, .cityNotFound)
                }
            } catch {
                completion(nil, .decodingError)
            }
        }
        task.resume()
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Weather?, WeatherError?) -> Void) {
        let urlString = "\(weatherBaseURL)?latitude=\(latitude)&longitude=\(longitude)&current_weather=true&timezone=auto&language=ru"
        
        guard let url = URL(string: urlString) else {
            completion(nil, .unknownError)
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: 15)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, .networkError(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, .unknownError)
                return
            }
            
            guard let data = data else {
                completion(nil, .decodingError)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let description = self.mapWeatherCodeToDescription(code: weatherResponse.current_weather.weathercode)
                let icon = self.mapWeatherCodeToIcon(code: weatherResponse.current_weather.weathercode)
                
                let weather = Weather(
                    temperature: weatherResponse.current_weather.temperature,
                    description: description,
                    icon: icon, weatherCode: weatherResponse.current_weather.weathercode
                )
                
                completion(weather, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }
        task.resume()
    }
    
    private func mapWeatherCodeToDescription(code: Int) -> String {
        switch code {
        case 0:
            return "Ясно"
        case 1, 2, 3:
            return "Малооблачно"
        case 45, 48:
            return "Туман"
        case 51, 53, 55:
            return "Незначительные осадки"
        case 61, 63, 65:
            return "Дождь"
        case 71, 73, 75:
            return "Снег"
        case 80, 81, 82:
            return "Ливень"
        case 95, 96, 99:
            return "Гроза"
        default:
            return "Неизвестно"
        }
    }
    
    private func mapWeatherCodeToIcon(code: Int) -> String {
        switch code {
        case 0:
            return "clear-day"
        case 1, 2, 3:
            return "cloudy"
        case 45, 48:
            return "fog"
        case 51, 53, 55:
            return "drizzle"
        case 61, 63, 65:
            return "rain"
        case 71, 73, 75:
            return "snow"
        case 80, 81, 82:
            return "rain-heavy"
        case 95, 96, 99:
            return "storm"
        default:
            return "unknown"
        }
    }
    
     func mapWeatherCodeToOpenWeatherIcon(code: Int) -> String {
        switch code {
        case 0:
            return "01d"
        case 1, 2, 3:
            return "02d"
        case 45, 48:
            return "50d"
        case 51, 53, 55:
            return "09d"
        case 61, 63, 65:
            return "10d"
        case 71, 73, 75:
            return "13d"
        case 80, 81, 82:
            return "09d"
        case 95, 96, 99:
            return "11d"
        default:
            return "01d"
        }
    }
}
