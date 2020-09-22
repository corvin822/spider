//
//  ScoreProviding.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 31..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

class ResultProvider {
    
    let storage = UserDefaults.standard
    let storagePlayer = UserDefaults.standard
    
    func clearResults(of gameType: GameType) {
        storage.removeObject(forKey: gameType.storageKey)
        storage.synchronize()
    }
    
    func getResults(for gameType: GameType) -> [GameResult] {
        guard let data = storage.object(forKey: gameType.storageKey) as? Data else {
            return []
        }
        
        let decodedGameType = try? PropertyListDecoder().decode([GameResult].self, from: data)
        return decodedGameType ?? []
    }
    
    func save(results: [GameResult], of gameType: GameType) {
        storage.set(try? PropertyListEncoder().encode(results), forKey: gameType.storageKey)
        storage.synchronize()
    }
}

private extension GameType {
    var storageKey: String {
        switch self {
        case .result30:
            return "result_30"
        case .result45:
            return "result_45"
        case .result60:
            return "result_60"
        }
    }
}
