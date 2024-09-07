//
//  HomeControllerViewModel.swift
//  MiniApps
//
//  Created by Василий Тихонов on 06.09.2024.
//

import UIKit

class CryptoControllerViewModel {
    
    var onCoinsUpdated: (() -> Void)?
    var onErrorMessage: ((CoinServiceError) -> Void)?
    
    private var inSearchMode: Bool = false
    
    var coins: [Coin] {
        return inSearchMode ? filteredCoins : allCoins
    }
    
    private(set) var allCoins: [Coin] = [] {
        didSet {
            self.onCoinsUpdated?()
        }
    }
    
    private(set) var filteredCoins: [Coin] = []
    
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                print("DEBUG PRINT:", "\(coins.count) coins fetched.")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }

    public func updateSearchController(searchBarText: String?) {
        let searchText = searchBarText?.lowercased() ?? ""
        
        if searchText.isEmpty {
            inSearchMode = false
        } else {
            inSearchMode = true
            filteredCoins = allCoins.filter { $0.name.lowercased().contains(searchText) }
        }
        self.onCoinsUpdated?()
    }
}
