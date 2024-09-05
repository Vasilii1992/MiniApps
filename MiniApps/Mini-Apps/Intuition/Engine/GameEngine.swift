//
//  GameEngine.swift
//  MiniApps
//
//  Created by Василий Тихонов on 05.09.2024.
//

import Foundation

final class GameEngine {
    
    private var userDefaults = UserDefaults.standard
    
    var score: Int = 0
    var record: Int
    
    init() {
        self.record = userDefaults.integer(forKey: StorageKeys.record.rawValue)
    }
    
    private func getRandomValue() -> Bool {
        Bool.random()
    }
    
    private func roundWin() {
        score += 1
        if record < score {
            userDefaults.setValue(score, forKey: StorageKeys.record.rawValue)
            self.record = score
        }
    }
    private func roundFall() {
        score = 0
    }
    
    func gameAction(side: Bool) -> Bool {
        let random = getRandomValue()
        side == random ? roundWin() : roundFall()
        
        return side == random
    }
}

enum StorageKeys: String {
    case record
}
