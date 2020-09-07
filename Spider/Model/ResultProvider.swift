//
//  ScoreProviding.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 31..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

//TODO: rev-ALi: Jobb elnevezés lenne a GameType
enum ResultType {
    case result30
    case result45
    case result60
}

typealias Score = Int

class ResultProvider {
    
    let storage = UserDefaults.standard
    
    //TODO: rev-ALi: a típus átnevezés miatt itt jobb lenne a következő elnevezés:
    // func clearResults(of gameType: GameType)
    func clear(resultType: ResultType) {
        storage.removeObject(forKey: resultType.storageKey)
        storage.synchronize()
    }
    
    //TODO: rev-ALi: átnevezés resultType -> gameType
    func getResults(for resultType: ResultType) -> [Score] {
        guard let results = storage.value(forKey: resultType.storageKey) as? [Score] else {
            return []
        }
        return results
    }
    
    //TODO: rev-ALi: átnevezés resultType -> gameType
    func save(results: [Score], of resultType: ResultType) {
        storage.set(Array(results.prefix(3)), forKey: resultType.storageKey)
        storage.synchronize()
    }
}

extension ResultType {
    var storageKey: String {
        switch self {
        case .result30:
            return "result30"
        case .result45:
            return "result45"
        case .result60:
            return "result60"
        }
    }
}
