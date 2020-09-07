//
//  ViewController.swift
//  FirstPlace
//
//  Created by Dukai Andrea on 2020. 08. 29..
//  Copyright © 2020. Dukai Andrea. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var cupImage: UIImageView!
    @IBOutlet weak var icecreamImage: UIImageView!
    @IBOutlet weak var podiumImage: UIImageView!
    
    @IBOutlet weak var labelSorry: UILabel!
    @IBOutlet weak var labelCongratulation: UILabel!
    @IBOutlet weak var labelPlace: UILabel!
    
    @IBOutlet weak var result1: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result3: UILabel!
    
    @IBOutlet weak var cup1View: UIView!
    @IBOutlet weak var cup2View: UIView!
    @IBOutlet weak var cup3View: UIView!
    
    class Args {
        var results: Int = 0
        var resultType: ResultType = .result30
    }
    
    private var place: ResultCalculator.Ranking = .none
    var args: Args = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Eredményhirdetés"
        let resultCalculator = ResultCalculator()
        place = resultCalculator.recordResult(args.results, resultType: args.resultType)
        screenData(place)
    }
    
    @IBAction func backToResultsListButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func screenData(_ place: ResultCalculator.Ranking){
        podiumImage.image = args.resultType.imagePodium
        switch place {
        case .first:
            cupImage.isHidden = false
            cupImage.image = args.resultType.imageCup
            icecreamImage.isHidden = true
            labelCongratulation.text = "GRATULÁLUNK!"
            labelSorry.text = ""
            labelPlace.text = "Első helyezett lettél"
            cup1View.isHidden = false
            cup2View.isHidden = true
            cup3View.isHidden = true
            result1.text = "\(args.results)"
        case .second:
            cupImage.isHidden = false
            cupImage.image = args.resultType.medal2
            icecreamImage.isHidden = true
            labelCongratulation.text = "GRATULÁLUNK!"
            labelSorry.text = ""
            labelPlace.text = "Második helyezett lettél"
            cup1View.isHidden = true
            cup2View.isHidden = false
            cup3View.isHidden = true
            result2.text = "\(args.results)"
        case .third:
            cupImage.isHidden = false
            cupImage.image = args.resultType.medal3
            icecreamImage.isHidden = true
            labelCongratulation.text = "GRATULÁLUNK!"
            labelSorry.text = ""
            labelPlace.text = "Harmadik helyezett lettél"
            cup1View.isHidden = true
            cup2View.isHidden = true
            cup3View.isHidden = false
            result3.text = "\(args.results)"
        case .none:
            icecreamImage.isHidden = false
            icecreamImage.image = UIImage(named: "icecream")!
            cupImage.isHidden = true
            labelCongratulation.text = ""
            labelSorry.text = "Sajnos ez most nem sikerült"
            labelPlace.text = "Egyél egy jégkrémet!"
            cup1View.isHidden = true
            cup2View.isHidden = true
            cup3View.isHidden = true
        }
    }
}

