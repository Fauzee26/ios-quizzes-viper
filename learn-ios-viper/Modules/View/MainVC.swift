//
//  MainVC.swift
//  learn-ios-viper
//
//  Created by Muhammad Hilmy Fauzi on 02/09/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit
import Alamofire

protocol MainViewProtocol: AnyObject {
    var presenterView: MainPresenterViewProtocol? {get set}
    var interactor: MainInteractorProtocol? {get set}
    var router: MainRouterProtocol? {get set}
    
    func getData()
    func resetState()
    
    func nextQuizPressed()
    func setQuizzes(list: [Quiz])
    func checkAnswer(userAnswer: String) -> Bool
}

class MainVC: UIViewController {
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnTrue: UIButton!
    @IBOutlet weak var btnFalse: UIButton!
    @IBOutlet weak var lblDifficulty: UILabel!
    
    var presenter: MainViewProtocol?
    let alert = UIAlertController(title: nil, message: "Generating Quizzes...", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTrue.layer.cornerRadius = 12
        btnTrue.layer.borderWidth = 3
        btnTrue.layer.borderColor = #colorLiteral(red: 0.08235294118, green: 0.3215686275, blue: 0.3882352941, alpha: 1)
        
        btnFalse.layer.cornerRadius = 12
        btnFalse.layer.borderWidth = 3
        btnFalse.layer.borderColor = #colorLiteral(red: 0.08235294118, green: 0.3215686275, blue: 0.3882352941, alpha: 1)
        
        lblDifficulty.layer.cornerRadius = 4
        
        DispatchQueue.main.async {
            self.loadingProgress()
            self.presenter?.getData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    @IBAction func btnAnswerClicked(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!

        let isAnswer = presenter?.checkAnswer(userAnswer: userAnswer)
        if isAnswer! {
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.backgroundColor = UIColor.systemGreen
        } else {
            sender.layer.borderColor = UIColor.systemRed.cgColor
            sender.backgroundColor = UIColor.systemRed
        }

        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(clearState), userInfo: nil, repeats: false)
    }
    
    @objc func clearState() {
        btnTrue.layer.borderColor = #colorLiteral(red: 0.08235294118, green: 0.3215686275, blue: 0.3882352941, alpha: 1)
        btnFalse.layer.borderColor = #colorLiteral(red: 0.08235294118, green: 0.3215686275, blue: 0.3882352941, alpha: 1)
        
        btnTrue.backgroundColor = UIColor.clear
        btnFalse.backgroundColor = UIColor.clear

        presenter?.nextQuizPressed()
    }
    
    private func  loadingProgress() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainVC: MainPresenterViewProtocol {
    func onNextQuestionPressed(nextQuiz: Quiz, currentProgress: Float, currentScore: Int, bgColor: UIColor, isFinished: Bool) {
        lblQuestion.text = nextQuiz.question.htmlDecoded()
        lblCategory.text = nextQuiz.category
        
        lblDifficulty.backgroundColor = bgColor
        lblDifficulty.text = "  \(nextQuiz.difficulty.uppercased())  "
        
        lblScore.text = String(describing: currentScore)
        progress.progress = currentProgress
        
        print("progress: ", currentProgress)
        
        if isFinished {
            print("all finished already")
            if currentScore <= 20 {
                alertFinished(title: "LOL", msg: "You suck. Just scored \(currentScore) HUH?")
            } else if currentScore <= 50 {
                alertFinished(title: "Nope", msg: "You're not qualified. You scored \(currentScore)")
            } else if currentScore <= 70 {
                alertFinished(title: "Yeayy", msg: "Amazing, You can do more. You scored \(currentScore)")
            } else {
                alertFinished(title: "Yeayy", msg: "You're Genius, Keep it up. You scored \(currentScore)")
            }
        }
    }
    
    func onQuizResponseSuccess(quizList: [Quiz]) {
        alert.dismiss(animated: true, completion: nil)
        presenter?.setQuizzes(list: quizList)
        presenter?.nextQuizPressed()
    }
    
    func onQuizResponseFailed(error: String) {
        alert.dismiss(animated: true, completion: nil)
        print(error)
    }
    
    func alertFinished(title: String, msg: String) {
        // "Yeayyy"
        // "You finished with score \(lblScore.text ?? "0"), dare to try again?"
        let alertController = UIAlertController(title: title
                                                , message: msg,
                                                preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Sure", style: .default) { (action:UIAlertAction) in
            self.presenter?.resetState()
            self.loadingProgress()
            self.presenter?.getData()
        }

        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
}
