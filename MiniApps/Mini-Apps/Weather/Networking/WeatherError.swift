
import Foundation

enum WeatherError: Error {
    case invalidCity
    case cityNotFound
    case networkError(Error)
    case decodingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidCity:
            return "Некорректный запрос"
        case .cityNotFound:
            return "Город не найден"
        case .networkError(let error):
            return "Ошибка сети: \(error.localizedDescription)"
        case .decodingError:
            return "Ошибка при декодировании данных"
        case .unknownError:
            return "Неизвестная ошибка"
        }
    }
}
