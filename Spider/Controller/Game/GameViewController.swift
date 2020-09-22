//
//  ViewController.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    class Arg {
        var gameType: GameType = .result30
        var selectedPlayer: PlayerType = .dog
    }
    
    var args: Arg = .init()
    
    @IBOutlet weak var labelResultScore: UILabel!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var imageArrowRight: UIImageView!
    @IBOutlet weak var imageArrowDown: UIImageView!
    @IBOutlet weak var imageArrowLeft: UIImageView!
    @IBOutlet weak var imageArrowUp: UIImageView!
    
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelSelectedPlayerIcon: UILabel!
    
    
    private var timer: Timer?
    private var positionSpider = 9
    private var positionWorm = 1
    private var resultScore = 0
    private var secondCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "\(args.selectedPlayer.playerName) vadászat"
        labelSelectedPlayerIcon.text = args.selectedPlayer.countedAnimal
        
        secondCount = args.gameType.gameLenght
        
        labelTimer.text = "\(secondCount) "
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSecondCounter), userInfo: nil, repeats: true)
        
        hunterArea()
        
        let tapGestureRecognizerArrowRight = UITapGestureRecognizer(target: self, action: #selector(imageArrowRightTapped(tapGestureRecognizer:)))
        imageArrowRight.isUserInteractionEnabled = true
        imageArrowRight.addGestureRecognizer(tapGestureRecognizerArrowRight)
        
        let tapGestureRecognizerArrowDown = UITapGestureRecognizer(target: self, action: #selector(imageArrowDownTapped(tapGestureRecognizer:)))
        imageArrowDown.isUserInteractionEnabled = true
        imageArrowDown.addGestureRecognizer(tapGestureRecognizerArrowDown)
        
        let tapGestureRecognizerArrowLeft = UITapGestureRecognizer(target: self, action: #selector(imageArrowLeftTapped(tapGestureRecognizer:)))
        imageArrowLeft.isUserInteractionEnabled = true
        imageArrowLeft.addGestureRecognizer(tapGestureRecognizerArrowLeft)
        
        let tapGestureRecognizerArrowUp = UITapGestureRecognizer(target: self, action: #selector(imageArrowUpTapped(tapGestureRecognizer:)))
        imageArrowUp.isUserInteractionEnabled = true
        imageArrowUp.addGestureRecognizer(tapGestureRecognizerArrowUp)
    }
    
    @objc func imageArrowRightTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if positionSpider % 3 != 0 {
            let tappedImage = tapGestureRecognizer.view as! UIImageView
            buttonAction(1)
        }
    }
    
    @objc func imageArrowDownTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if positionSpider <= 6 {
            let tappedImage = tapGestureRecognizer.view as! UIImageView
            buttonAction(3)
        }
    }
    
    @objc func imageArrowLeftTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if (positionSpider + 2) % 3 != 0 {
            let tappedImage = tapGestureRecognizer.view as! UIImageView
            buttonAction(-1)
        }
    }
    
    @objc func imageArrowUpTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if positionSpider >= 4 {
            let tappedImage = tapGestureRecognizer.view as! UIImageView
            buttonAction(-3)
        }
    }
    
    private func hunterArea () {
        getLabelByPosition(1)?.text = args.selectedPlayer.countedAnimal
        getLabelByPosition(9)?.text = args.selectedPlayer.hunter
        var index = 2
        while index < 9 {
            getLabelByPosition(index)?.text = args.selectedPlayer.hunterArea
            getLabelByPosition(index)?.alpha = 0.25
            index += 1
        }
    }
    
    @objc func updateSecondCounter() {
        
        if secondCount > 1 {
            secondCount -= 1
            labelTimer.text = "\(secondCount)"
        } else  {
            labelTimer.text = "0"
            timer?.invalidate()
            performSegue(withIdentifier: "result", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.args.results = resultScore
            resultViewController.args.gameType = args.gameType
            resultViewController.args.selectedPlayer = args.selectedPlayer
        }
    }
    
    private func getLabelByPosition(_ position: Int) -> UILabel? {
        view.viewWithTag(position) as? UILabel
    }
    
    private func buttonAction(_ getPosition: Int) {
        getLabelByPosition(positionSpider)?.text = args.selectedPlayer.hunterArea
        getLabelByPosition(positionSpider)?.alpha = 0.25
        positionSpider += getPosition
        if positionWorm == positionSpider {
            resultScore += 1
            labelResultScore.text = "\(resultScore)"
            while positionWorm == positionSpider {
                positionWorm = Int.random(in: 1...9)
                getLabelByPosition(positionWorm)?.text = args.selectedPlayer.countedAnimal
                getLabelByPosition(positionWorm)?.alpha = 1.0
            }
        }
        getLabelByPosition(positionSpider)?.text = args.selectedPlayer.hunter
        getLabelByPosition(positionSpider)?.alpha = 1.0
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
    
    var countedAnimal: String {
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
    
    var hunterArea: String {
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
