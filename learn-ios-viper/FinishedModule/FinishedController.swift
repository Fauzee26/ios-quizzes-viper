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
    var score = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = score
    }
    
    @IBAction func playAgain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
