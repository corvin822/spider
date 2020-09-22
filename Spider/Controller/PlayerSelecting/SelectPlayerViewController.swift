//
//  SelectPlayerViewController.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 09. 10..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class SelectPlayerViewController: UIViewController {
    
    class Arg {
        var gameType: GameType = .result30
    }
    
    var args: Arg = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Játékosok"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController,
            let segueId = segue.identifier,
            let playerType = PlayerType(rawValue: segueId) {
            gameViewController.args.gameType = args.gameType
            gameViewController.args.selectedPlayer = playerType
        }
    }
}
