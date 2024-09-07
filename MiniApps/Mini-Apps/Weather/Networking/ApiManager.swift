
import Foundation

final class APIManager {
    
    private let apiKey = "ed731eb179561dee75d942a3434116a2"
    
    func load(city: String, completion: @escaping (Weather?, WeatherError?) -> Void) {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded ?? "")&appid=\(apiKey)&units=metric&lang=ru") else {
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
            
            guard let data = data, let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                completion(nil, .decodingError)
                return
            }
            completion(weather, nil)
        }
        task.resume()
    }
}
