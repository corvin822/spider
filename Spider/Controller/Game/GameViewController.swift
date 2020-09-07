//
//  ViewController.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    class Args {
        var resultType: ResultType = .result30
    }
    
    var args: Args = .init()
    
    //TODO: rev-ALi: beszédes neveket használjunk, a többi outlet jó, de ezt nem tudom megfejteni
    @IBOutlet weak var label0: UILabel!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var labelTimer: UILabel!
    
    //TODO: rev-ALi: ezek a property-k miért publikusak?
    var timer: Timer?
    
    var positionSpider = 9
    var positionWorm = 1

    //TODO: rev-ALi: beszédes neveket használjunk, a többi property elnevezés jó, de ezt nem tudom megfejteni
    var i = 1
    var resultScore = 0
    //TODO: rev-ALi: túl általános elnevezés, minősíteni kéne azzal, hogy mit számol
    // secondCount
    var counter: Int = 0
    
    //TODO: rev-ALi: elég egy üres sort kihagyni tagolásként

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Kukasz vadászat"
        
        counter = args.resultType.gameLenght
        
        labelTimer.text = "\(counter) "
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    //TODO: rev-ALi: a counter átnevezése után ezt a függvényt is érdemes volna átnevezni
    @objc func updateCounter() {
        
        if counter > 1 {
            counter -= 1
            labelTimer.text = "\(counter)"
        } else  {
            labelTimer.text = "0"
            timer?.invalidate()
            performSegue(withIdentifier: "result", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.args.results = resultScore
            resultViewController.args.resultType = args.resultType
        }
    }
    
    override func viewDidLayoutSubviews() {
        upButton.layer.cornerRadius = upButton.bounds.width/2
        downButton.layer.cornerRadius = downButton.bounds.width/2
        leftButton.layer.cornerRadius = leftButton.bounds.width/2
        rightButton.layer.cornerRadius = rightButton.bounds.width/2
        
    }
    private func getLabelByPosition(_ position: Int) -> UILabel? {
        view.viewWithTag(position) as? UILabel
    }
    
    private func buttonAction(_ getPosition: Int) {
        getLabelByPosition(positionSpider)?.text = "🕸"
        positionSpider += getPosition
        if positionWorm == positionSpider {
            resultScore += 1
            label0.text = "\(resultScore)"
            while positionWorm == positionSpider {
                positionWorm = Int.random(in: 1...9)
                getLabelByPosition(positionWorm)?.text = "🐛"
            }
        }
        getLabelByPosition(positionSpider)?.text = "🕷"
        
        downButton.isEnabled = positionSpider <= 6
        upButton.isEnabled = positionSpider >= 4
        leftButton.isEnabled = (positionSpider + 2) % 3 != 0
        rightButton.isEnabled = positionSpider % 3 != 0
    }
    
    @IBAction func upButtonAction(_ sender: UIButton) {
        buttonAction(-3)
    }
    
    @IBAction func downButtonAction(_ sender: UIButton) {
        buttonAction(3)
    }
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        buttonAction(-1)
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        buttonAction(1)
    }
}
