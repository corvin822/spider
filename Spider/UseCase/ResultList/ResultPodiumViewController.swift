//
//  containerViewController.swift
//  countdownTimer
//
//  Created by Dukai Andrea on 2020. 08. 27..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class ResultPodiumViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var podiumImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var cup1HolderView: UIView!
    @IBOutlet weak var cup1ResultLabel: UILabel!
    @IBOutlet weak var cup2HolderView: UIView!
    @IBOutlet weak var cup2ResultLabel: UILabel!
    @IBOutlet weak var cup3HolderView: UIView!
    @IBOutlet weak var cup3ResultLabel: UILabel!
    @IBOutlet weak var labelFirstPlayer: UILabel!
    @IBOutlet weak var labelSecondPlayer: UILabel!
    @IBOutlet weak var labelThirdPlayer: UILabel!
    
    
    // MARK: - Properties
    
    class Arg {
        var gameType: GameType = .result30
    }
    
    var args: Arg = .init()
    private let resultProvider: ResultProvider = .init()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.backgroundColor = args.gameType.buttonColor
        actionButton.setTitle(args.gameType.buttonTitle, for: .normal)
        podiumImageView.image = args.gameType.imagePodium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for (index, result) in resultProvider.getResults(for: args.gameType).enumerated() {
            if index == 0 {
                cup1HolderView.isHidden = false
                cup1ResultLabel.text = String(result.score)
                labelFirstPlayer.isHidden = false
                labelFirstPlayer.text = String(result.playerType.hunter)
            }
            if index == 1 {
                cup2HolderView.isHidden = false
                cup2ResultLabel.text = String(result.score)
                labelSecondPlayer.isHidden = false
                labelSecondPlayer.text = String(result.playerType.hunter)
            }
            if index == 2 {
                cup3HolderView.isHidden = false
                cup3ResultLabel.text = String(result.score)
                labelThirdPlayer.isHidden = false
                labelThirdPlayer.text = result.playerType.hunter
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectPlayer", let selectPlayerViewController = segue.destination as? SelectPlayerViewController{
            selectPlayerViewController.args.gameType = args.gameType
        }
    }
}

// MARK: - ResultType extension

extension GameType {
    var buttonColor: UIColor {
        switch self {
        case .result30:
            return UIColor(named: "kukaszBlue")!
        case .result45:
            return UIColor(named: "kukaszOrange")!
        case .result60:
            return UIColor(named: "kukaszRed")!
        }
    }
    
    var buttonTitle: String {
        "\(gameLenght) másodperces vadászat"
    }
    
    var imagePodium: UIImage {
        UIImage(named: "podium\(gameLenght)")!
    }

    var gameLenght: Int {
        switch self {
        case .result30:
            return 30
        case .result45:
            return 45
        case .result60:
            return 60
        }
    }
}
