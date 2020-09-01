//
//  ViewController.swift
//  countdownTimer
//
//  Created by Dukai Andrea on 2020. 08. 20..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class ResultListViewController: UIViewController, ResultPodiumViewControllerDelegate {
    
//    var timer: Timer?
    
    let resultProvider: ResultProvider = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "first", let containerViewController = segue.destination as? ResultPodiumViewController {
            containerViewController.args.resultType = .result30
            containerViewController.args.results = resultProvider.getResults(for: .result30)
            containerViewController.delegate = self
        }
        if segue.identifier == "second", let containerViewController = segue.destination as? ResultPodiumViewController {
            containerViewController.args.resultType = .result45
            containerViewController.args.results = [38]
            containerViewController.delegate = self
        }
        if segue.identifier == "third", let containerViewController = segue.destination as? ResultPodiumViewController {
            containerViewController.args.resultType = .result60
            containerViewController.args.results = [45, 39, 31]
            containerViewController.delegate = self
        }
    }
    
    func actionButtonTapped(resultType: ResultType) {
        performSegue(withIdentifier: "startGame", sender: resultType)
    }

//    var counter: Int = 0
//
//    func runTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//    }
//
//    @IBAction func actionButton30(_ sender: UIButton) {
//        counter = 30
//        runTimer()
//    }
//
//    @IBAction func actionButton45(_ sender: UIButton) {
//        counter = 45
//        runTimer()
//    }
//
//    @IBAction func actionButton60(_ sender: UIButton) {
//        counter = 60
//        runTimer()
//    }
//
//    @objc func updateCounter() {
//        if counter >= 0 {
//            labelTimer.text = "\(counter) "
//            counter -= 1
//        }
//
//        else  {
//            timer?.invalidate()
//        }
//    }
    
}

