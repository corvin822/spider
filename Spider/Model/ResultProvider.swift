//
//  ScoreProviding.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 31..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

enum ResultType {
    case result30
    case result45
    case result60
}

typealias Score = Int

class ResultProvider {
    
    func getResults(for resultType: ResultType) -> [Score] {
        return []
    }
    
    func save(results: [Score], of resultType: ResultType) {
        
    }
}
