//
//  ViewController.swift
//  countdownTimer
//
//  Created by Dukai Andrea on 2020. 08. 20..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class ResultListViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "first", let containerViewController = segue.destination as? ResultPodiumViewController {
            containerViewController.args.gameType = .result30
        }
        if segue.identifier == "second", let containerViewController = segue.destination as? ResultPodiumViewController {
            containerViewController.args.gameType = .result45
        }
        if segue.identifier == "third", let containerViewController = segue.destination as? ResultPodiumViewController {
            containerViewController.args.gameType = .result60
        }
    }
}
