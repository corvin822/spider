//
//  containerViewController.swift
//  countdownTimer
//
//  Created by Dukai Andrea on 2020. 08. 27..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

protocol ResultPodiumViewControllerDelegate: class {
    func actionButtonTapped(resultType: ResultType)
}

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
        var results: [Int] = .init()
    }
    
    var args: Arg = .init()
    weak var delegate: ResultPodiumViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.backgroundColor = args.resultType.buttonColor
        actionButton.setTitle(args.resultType.buttonTitle, for: .normal)
        podiumImageView.image = args.resultType.imagePodium
        
        for (index, result) in args.results.enumerated() {
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
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        delegate?.actionButtonTapped(resultType: args.resultType)
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
}
