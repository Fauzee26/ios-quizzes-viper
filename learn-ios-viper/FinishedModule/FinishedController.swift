//
//  FinishedController.swift
//  learn-ios-viper
//
//  Created by Farras Doko on 17/10/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

class FinishedController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(describing: score)
    }
    
    @IBAction func playAgain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let startVc = storyboard.instantiateViewController(withIdentifier: "StartController") as? StartController else { return }
        self.navigationController?.setViewControllers([startVc], animated: true)
    }
    
}
