//
//  ViewController.swift
//  FirstPlace
//
//  Created by Dukai Andrea on 2020. 08. 29..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var cupImage: UIImageView!
    @IBOutlet weak var icecreamImage: UIImageView!
    @IBOutlet weak var podiumImage: UIImageView!
    
    @IBOutlet weak var labelSorry: UILabel!
    @IBOutlet weak var labelCongratulation: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    
    @IBOutlet var resultLabels: [UILabel]!
    @IBOutlet var cupViews: [UIView]!
    
    class Arg {
        var results: Score = 0
        var gameType: GameType = .result30
        var selectedPlayer: PlayerType = .dog
    }
    
    var args: Arg = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Eredményhirdetés"
        screenData(rankingCalculator())
    }
    
    private func rankingCalculator() -> Ranking {
        let resultCalculator = ResultCalculator()
        return resultCalculator.recordResult(
            GameResult(score: args.results, playerType: args.selectedPlayer),
            gameType: args.gameType)
    }
    
    @IBAction func backToResultsListButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func showAwardImage(_ gameType: GameType, _ place: Ranking) {
        cupImage.isHidden = place == .none
        icecreamImage.isHidden = place != .none
        cupImage.image = place.rewardImage(gameType)
    }
    
    private func showResultTexts(_ gameType: GameType, _ place: Ranking) {
        labelSorry.text = ""
        labelCongratulation.text = "GRATULÁLUNK!"
        labelPlace.text = place.resultText()
        if place == .none {
            labelSorry.text = "Sajnos ez most nem sikerült"
            labelCongratulation.text = ""
            labelPlace.text = "Egyél egy jégkrémet!"
        }
    }
    
    private func showResultOnPodium(_ place: Ranking) {
        var index = 0
        while 3 > index {
            cupViews[index].isHidden = true
            index += 1
        }
        if place != .none {
            cupViews[place.rawValue].isHidden = false
            resultLabels[place.rawValue].text = "\(args.results)"
        }
    }
    
    private func screenData(_ place: Ranking){
        podiumImage.image = args.gameType.imagePodium
        showAwardImage(args.gameType, place)
        showResultTexts(args.gameType, place)
        showResultOnPodium(place)
    }
}

extension Ranking {
    
    var medalColorName: String {
        switch self {
        case .first, .none:
            return ""
        case .second:
            return "silver"
        case .third:
            return "bronze"
        }
    }
    
    var placeText: String {
        switch self {
        case .first:
            return "Első"
        case .second:
            return "Második"
        case .third:
            return "Harmadik"
        case .none:
            return ""
        }
    }
    
    func rewardImage(_ gameType: GameType) -> UIImage? {
        guard self != .none else { return nil }
        
        if self == .first {
            return UIImage(named: "cup\(gameType.gameLenght)")
        }
        
        return UIImage(named: "medal\(gameType.gameLenght)\(self.medalColorName)")
    }
    
    func resultText() -> String {
        return "\(self.placeText) helyezett lettél"
    }
}
