//
//  MainVC.swift
//  learn-ios-viper
//
//  Created by Muhammad Hilmy Fauzi on 02/09/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnTrue: UIButton!
    @IBOutlet weak var btnFalse: UIButton!
    @IBOutlet weak var lblDifficulty: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTrue.layer.cornerRadius = 12
        btnTrue.layer.borderWidth = 3
        btnTrue.layer.borderColor = #colorLiteral(red: 0.08235294118, green: 0.3215686275, blue: 0.3882352941, alpha: 1)
        
        btnFalse.layer.cornerRadius = 12
        btnFalse.layer.borderWidth = 3
        btnFalse.layer.borderColor = #colorLiteral(red: 0.08235294118, green: 0.3215686275, blue: 0.3882352941, alpha: 1)
        
        lblDifficulty.layer.cornerRadius = 4
        lblDifficulty.backgroundColor = UIColor.systemRed
        lblDifficulty.text = "  HARD  "
        
        
        lblQuestion.text = "The movie &amp;quot;The Nightmare before Christmas&amp;quot; was all done with physical objects.".htmlDecoded()
    }
    
    @IBAction func btnAnswerClicked(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        
        print(userAnswer)
        
        sender.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
}
