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
    
    //TODO: rev-ALi: ezeket be lehet rakni IBOutlet collection-be, sokkal egyszerűbb lesz a kezelés, majd megmutatom, szólj
    @IBOutlet weak var result1: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBOutlet weak var result3: UILabel!
    
    //TODO: rev-ALi: ezeket be lehet rakni IBOutlet collection-be, sokkal egyszerűbb lesz a kezelés, majd megmutatom, szólj
    @IBOutlet weak var cup1View: UIView!
    @IBOutlet weak var cup2View: UIView!
    @IBOutlet weak var cup3View: UIView!
    
    class Args {
        //TODO: rev-ALi: itt miért használunk többesszámot?
        //TODO: rev-ALi: az eredmények típusára már bevezettük a Score-t
        var results: Int = 0
        var resultType: ResultType = .result30
    }
    
    //TODO: rev-ALi: sorrendben érdemes előre rendezni a publikus property-ket, majd utánuk egy üres sort követően a private property-ket
    private var place: ResultCalculator.Ranking = .none
    var args: Args = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        title = "Eredményhirdetés"
        //TODO: rev-ALi: a helyezés megállapítását kiraknám egy private függvénybe
        let resultCalculator = ResultCalculator()
        place = resultCalculator.recordResult(args.results, resultType: args.resultType)
        screenData(place)
    }
    
    @IBAction func backToResultsListButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    //TODO: rev-ALi: ez a függvény kivülről is hívható?
    func screenData(_ place: ResultCalculator.Ranking){
        podiumImage.image = args.resultType.imagePodium
        switch place {
        case .first:
            //TODO: rev-ALi: ezt kiraknám egy showAwardImage(ResultType) metódusba és akkor a switch sem kell
            cupImage.isHidden = false
            cupImage.image = args.resultType.imageCup
            icecreamImage.isHidden = true
            
            //TODO: rev-ALi: ezt kiraknám egy showResultTexts(ResultType) metódusba és akkor a switch sem kell
            labelCongratulation.text = "GRATULÁLUNK!"
            labelSorry.text = ""
            labelPlace.text = "Első helyezett lettél"
            
            //TODO: rev-ALi: ezt kiraknám egy showResultOnPodium(ResultType) metódusba és akkor a switch sem kell
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
            //TODO: rev-ALi: erre az image betöltésre biztosan szükség van?
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

