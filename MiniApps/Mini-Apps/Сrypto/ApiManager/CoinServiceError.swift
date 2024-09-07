
import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}
