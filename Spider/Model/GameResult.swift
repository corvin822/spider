//
//  GameResult.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 09. 13..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

typealias Score = Int

class GameResult: Codable {
    var score: Score
    var playerType: PlayerType
    
    init(score: Score, playerType: PlayerType) {
        self.score = score
        self.playerType = playerType
    }
}
