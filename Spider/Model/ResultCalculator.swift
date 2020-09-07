//
//  ResultCalculator.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 09. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

class ResultCalculator {

    enum Ranking: Int {
        case first = 0
        case second = 1
        case third = 2
        case none = 3
    }
    
    private let resultProvider = ResultProvider()
    
    func recordResult(_ score: Score, resultType: ResultType) -> Ranking {
        var results = resultProvider.getResults(for: resultType)
        var index = 0
        while results.count > index, results[index] > score {
            index += 1
        }
        
        if index <= 2 {
            results.insert(score, at: index)
            resultProvider.save(results: results, of: resultType)
        }
        
        if let retVal = Ranking(rawValue: index) {
            return retVal
        }
        
        return .none
    }
}
