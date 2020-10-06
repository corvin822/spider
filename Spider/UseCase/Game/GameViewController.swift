//
//  ViewController.swift
//  Spider
//
//  Created by Dukai Andrea on 2020. 08. 05..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class HunterAreaCellDesriptor {
    var symbol: String
    var alpha: CGFloat
    
    init(symbol: String, alpha: CGFloat) {
        self.symbol = symbol
        self.alpha = alpha
    }
}

protocol GameDisplaying {
    var navigator: UIViewController { get }
    
    func setupView()
    func show(huntedAnimalSign: String)
    func show(remainingSeconds: Int)
    func show(hunterAreaCell: HunterAreaCellDesriptor, at position: Int)
    func show(result: Int)
}

class GameViewController: UIViewController, GameDisplaying {
    
    class Arg {
        var gameType: GameType = .result30
        var selectedPlayer: PlayerType = .dog
    }
    
    var args: Arg = .init()
    var navigator: UIViewController {
        self
    }
    
    @IBOutlet weak var labelResultScore: UILabel!
    
    @IBOutlet weak var imageArrowRight: UIImageView!
    @IBOutlet weak var imageArrowDown: UIImageView!
    @IBOutlet weak var imageArrowLeft: UIImageView!
    @IBOutlet weak var imageArrowUp: UIImageView!
    
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var labelHuntedAnimalIcon: UILabel!
    
    private var presenter: GamePresenting!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = GamePresenter(display: self, gameType: args.gameType, player: args.selectedPlayer)
        presenter.viewLoaded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController, let resultScore = sender as? Int {
            resultViewController.args.results = resultScore
            resultViewController.args.gameType = args.gameType
            resultViewController.args.selectedPlayer = args.selectedPlayer
        }
    }
    
    // MARK: GameDisplaying
    
    func setupView() {
        navigationItem.hidesBackButton = true
        title = "\(args.selectedPlayer.playerName) vadászat"
    }
    
    func show(huntedAnimalSign: String) {
        labelHuntedAnimalIcon.text = huntedAnimalSign
    }
    
    func show(remainingSeconds: Int) {
        labelTimer.text = "\(remainingSeconds)"
    }
    
    func show(result: Int) {
        labelResultScore.text = "\(result)"
    }
    
    func show(hunterAreaCell: HunterAreaCellDesriptor, at position: Int) {
        getLabelByPosition(position)?.text = hunterAreaCell.symbol
        getLabelByPosition(position)?.alpha = hunterAreaCell.alpha
    }
    
    private func getLabelByPosition(_ position: Int) -> UILabel? {
        view.viewWithTag(position) as? UILabel
    }

    // MARK: User actions
    
    @IBAction func imageArrowRightTapped(tapGestureRecognizer: UITapGestureRecognizer){
        presenter.hunterMoved(to: .right)
    }
    
    @IBAction func imageArrowDownTapped(tapGestureRecognizer: UITapGestureRecognizer){
        presenter.hunterMoved(to: .down)
    }
    
    @IBAction func imageArrowLeftTapped(tapGestureRecognizer: UITapGestureRecognizer){
        presenter.hunterMoved(to: .left)
    }
    
    @IBAction func imageArrowUpTapped(tapGestureRecognizer: UITapGestureRecognizer){
        presenter.hunterMoved(to: .up)
    }
}
