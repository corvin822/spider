//
//  ViewController.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var label13: UILabel!
    @IBOutlet weak var label21: UILabel!
    @IBOutlet weak var label22: UILabel!
    @IBOutlet weak var label23: UILabel!
    @IBOutlet weak var label31: UILabel!
    @IBOutlet weak var label32: UILabel!
    @IBOutlet weak var label33: UILabel!
    @IBOutlet weak var label0: UILabel!

    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
   
    
    var positionSpider = 9
    var positionWorm = 1
    var i = 1
    var k = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
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
            k += 1
            label0.text = "\(k)"
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

