//
//  GamePresenting.swift
//  Spider
//
//  Created by ALi on 2020. 10. 04..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import Foundation

enum HuntingDirection {
    case left
    case right
    case up
    case down
}

protocol GamePresenting {
    init(display: GameDisplaying, gameType: GameType, player: PlayerType)
    func viewLoaded()
    func hunterMoved(to direction: HuntingDirection)
}

class GamePresenter: GamePresenting {
    
    private let display: GameDisplaying
    private let gameType: GameType
    private let player: PlayerType
    private var timer: Timer?
    private var secondCount: Int = 0
    private var hunterPosition = 9
    private var huntedAnimalPosition = 1
    private var resultScore = 0

    required init(display: GameDisplaying, gameType: GameType, player: PlayerType) {
        self.display = display
        self.gameType = gameType
        self.player = player
    }
    
    func viewLoaded() {
        display.setupView()
        display.show(huntedAnimalSign: player.huntedAnimal)
        initTimer()
        display.show(remainingSeconds: secondCount)
        showHunterArea()
    }
    
    func hunterMoved(to direction: HuntingDirection) {
        switch direction {
        case .left:
            if (hunterPosition + 2) % 3 != 0 {
                changeHunterPosition(by: -1)
            }
        case .right:
            if hunterPosition % 3 != 0 {
                changeHunterPosition(by: 1)
            }
        case .up:
            if hunterPosition >= 4 {
                changeHunterPosition(by: -3)
            }
        case .down:
            if hunterPosition <= 6 {
                changeHunterPosition(by: 3)
            }
        }
    }
    
    private func showHunterArea () {
        let hunter = HunterAreaCellDesriptor(symbol: player.hunter, alpha: 1.0)
        let huntedAnimal = HunterAreaCellDesriptor(symbol: player.huntedAnimal, alpha: 1.0)
        let emptyCell = HunterAreaCellDesriptor(symbol: player.emptyHunterAreaCell, alpha: 0.25)
        
        display.show(hunterAreaCell: hunter, at: 9)
        display.show(hunterAreaCell: huntedAnimal, at: 1)
        var position = 2
        while position < 9 {
            display.show(hunterAreaCell: emptyCell, at: position)
            position += 1
        }
    }

    private func initTimer() {
        secondCount = gameType.gameLenght
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSecondCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func updateSecondCounter() {
        if secondCount > 1 {
            secondCount -= 1
            display.show(remainingSeconds: secondCount)
        } else  {
            display.show(remainingSeconds: 0)
            timer?.invalidate()
            display.navigator.performSegue(withIdentifier: "result", sender: resultScore)
        }
    }

    private func changeHunterPosition(by movingOffset: Int) {
        display.show(
            hunterAreaCell: HunterAreaCellDesriptor(symbol: player.emptyHunterAreaCell, alpha: 0.25),
            at: hunterPosition
        )
        hunterPosition += movingOffset
        checkHuntingDone()
        display.show(
            hunterAreaCell: HunterAreaCellDesriptor(symbol: player.hunter, alpha: 1.0),
            at: hunterPosition
        )
    }
    
    private func checkHuntingDone() {
        if huntedAnimalPosition == hunterPosition {
            resultScore += 1
            display.show(result: resultScore)
            while huntedAnimalPosition == hunterPosition {
                huntedAnimalPosition = Int.random(in: 1...9)
                display.show(
                    hunterAreaCell: HunterAreaCellDesriptor(symbol: player.huntedAnimal, alpha: 1.0),
                    at: huntedAnimalPosition)
            }
        }
    }
}

extension PlayerType {
    var playerName: String {
        switch self {
        case .dog:
            return "Csonti"
        case .fox:
            return "Liba"
        case .spider:
            return "Kukasz"
        case .lion:
            return "Zsiri"
        case .cat:
            return "Egérke"
        }
    }
    
    var huntedAnimal: String {
        switch self {
        case .dog:
            return "🦴"
        case .fox:
            return "🦆"
        case .spider:
            return "🐛"
        case .lion:
            return "🦒"
        case .cat:
            return "🐁"
        }
    }
    
    var hunter: String {
        switch self {
        case .dog:
            return "🐶"
        case .fox:
            return "🦊"
        case .spider:
            return "🕷"
        case .lion:
            return "🦁"
        case .cat:
            return "🐱"
        }
    }
    
    var emptyHunterAreaCell: String {
        switch self {
        case .dog:
            return "🐾"
        case .fox:
            return "🌾"
        case .spider:
            return "🕸"
        case .lion:
            return "🌴"
        case .cat:
            return "🧀"
        }
    }
}
