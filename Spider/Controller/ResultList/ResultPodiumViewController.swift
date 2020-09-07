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
    
    // MARK: - Properties
    
    class Arg {
        var resultType: ResultType = .result30
    }
    
    var args: Arg = .init()
    //TODO: rev-ALi: ez a property miért public?
    let resultProvider: ResultProvider = .init()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.backgroundColor = args.resultType.buttonColor
        actionButton.setTitle(args.resultType.buttonTitle, for: .normal)
        podiumImageView.image = args.resultType.imagePodium
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for (index, result) in resultProvider.getResults(for: args.resultType).enumerated() {
            if index == 0 {
                cup1HolderView.isHidden = false
                cup1ResultLabel.text = String(result)
            }
            if index == 1 {
                cup2HolderView.isHidden = false
                cup2ResultLabel.text = String(result)
            }
            if index == 2 {
                cup3HolderView.isHidden = false
                cup3ResultLabel.text = String(result)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
            gameViewController.args.resultType = args.resultType
        }
    }
}

// MARK: - ResultType extension

extension ResultType {
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
    
    //TODO: rev-ALi: switch nélkül megoldható, egyetlen sorral
    var buttonTitle: String {
        switch self {
        case .result30:
            return "30 másodperces vadászat"
        case .result45:
            return "45 másodperces vadászat"
        case .result60:
            return "60 másodperces vadászat"
        }
    }
    
    //TODO: rev-ALi: switch nélkül megoldható, egyetlen sorral
    var imagePodium: UIImage {
        switch self {
        case .result30:
            return UIImage(named: "podium30")!
        case .result45:
            return UIImage(named: "podium45")!
        case .result60:
            return UIImage(named: "podium60")!
        }
    }

    var gameLenght: Int {
        switch self {
        case .result30:
            return 30
        case .result45:
            return 10
        case .result60:
            return 10
        }
    }
    
    //TODO: rev-ALi: switch nélkül megoldható, egyetlen sorral
    var imageCup: UIImage {
        switch self {
        case .result30:
            return UIImage(named: "cup30")!
        case .result45:
            return UIImage(named: "cup45")!
        case .result60:
            return UIImage(named: "cup60")!
        }
    }
    
    //TODO: rev-ALi: switch nélkül megoldható, egyetlen sorral
    //TODO: rev-ALi: az imageCup elnevezés jó, ahhoz képest nem értem honnan jön ez a medal2, nevezzük át az imageCup-nál alkalmazott minta szerint
    var medal2: UIImage {
        switch self {
        case .result30:
            return UIImage(named: "medal30silver")!
        case .result45:
            return UIImage(named: "medal45silver")!
        case .result60:
            return UIImage(named: "medal60silver")!
        }
    }
    
    //TODO: rev-ALi: switch nélkül megoldható, egyetlen sorral
    //TODO: rev-ALi: az imageCup elnevezés jó, ahhoz képest nem értem honnan jön ez a medal2, nevezzük át az imageCup-nál alkalmazott minta szerint
    var medal3: UIImage {
        switch self {
        case .result30:
            return UIImage(named: "medal30bronze")!
        case .result45:
            return UIImage(named: "medal45bronze")!
        case .result60:
            return UIImage(named: "medal60bronze")!
        }
    }
}
