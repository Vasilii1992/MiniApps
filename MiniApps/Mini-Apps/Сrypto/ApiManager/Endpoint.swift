
import Foundation

enum Endpoint {

    case fetchCoins(url:String = "/v1/cryptocurrency/listings/latest")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValues(for: self)
        
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchCoins:
            return [
            URLQueryItem(name: "limit", value: "150"),
            URLQueryItem(name: "sort", value: "market_cap"),
            URLQueryItem(name: "convert", value: "USD"), 
            URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
        }
    }
    
    private var httpMethod: String {
        
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue,
                          forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            self.setValue(Constants.API_KEY,
                          forHTTPHeaderField: HTTP.Headers.Key.apiKey.rawValue)
        }
    }
}
