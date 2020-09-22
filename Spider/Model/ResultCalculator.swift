//
//  ResultCalculator.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 09. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

class ResultCalculator {
    
    private let resultProvider = ResultProvider()
    
    func recordResult(_ gameResult: GameResult, gameType: GameType) -> Ranking {
        var results = resultProvider.getResults(for: gameType)
        var index = 0
        while results.count > index, results[index].score > gameResult.score {
            index += 1
        }
        
        if index <= 2 {
            results.insert(gameResult, at: index)
            resultProvider.save(results: results, of: gameType)
        }
        
        if let retVal = Ranking(rawValue: index) {
            return retVal
        }
        
        return .none
    }
}
