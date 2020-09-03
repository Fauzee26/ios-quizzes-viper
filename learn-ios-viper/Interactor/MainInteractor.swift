//
//  MainInteractor.swift
//  learn-ios-viper
//
//  Created by Muhammad Hilmy Fauzi on 02/09/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import Alamofire

protocol MainInteractorProtocol {
    var presenter: MainPresenterProtocol? {get set}
    func loadData()
    
    func nextQuiz()
    
    func setListQuiz(quizzes: [Quiz])
    func checkAnswer(_ userAnswer: String) -> Bool
}

class MainInteractor: MainInteractorProtocol {
    var presenter: MainPresenterProtocol?
    
    func loadData() {
        AF.request("https://opentdb.com/api.php?amount=20&type=boolean").responseJSON { (response) in
            if let safeData = response.data {
                let quizList = self.parseDataQuizJSON(data: safeData)
                if let listQuizNotNil = quizList {
                    self.presenter?.quizSuccess(quizList: listQuizNotNil)
                } else {
                    self.presenter?.quizFailed(error: "Data Not Found")
                }
            } else {
                self.presenter?.quizFailed(error: "Data not there")
            }
        }
    }
    
    private func parseDataQuizJSON(data: Data) -> [Quiz]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseQuiz.self, from: data)
            return decodedData.results
        } catch {
            return nil
        }
    }
    
    private var questionNumber = 0
    private var score = 0
    private var listQuiz = [Quiz]()
    
    func setListQuiz(quizzes: [Quiz]) {
        listQuiz = quizzes
    }
    
    func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == listQuiz[questionNumber].correct_answer {
            score += 5
            return true
        } else {
            return false
        }
    }
    
    private func getScore() -> Int {
        return score
    }
    
    private func getNextQuiz() -> Quiz {
        return listQuiz[questionNumber]
    }
    
    private func getProgress() -> Float {
        return Float(questionNumber + 1) / Float(listQuiz.count)
    }
    
    func getBgColor(level: String) -> UIColor {
        if level == "easy" {
            return UIColor.systemGreen
        } else if level == "medium" {
            return UIColor.systemOrange
        } else {
            return UIColor.red
        }
    }
    
    func nextQuestion() {
        if questionNumber + 1 < listQuiz.count {
            questionNumber += 1
        } else {
            print("end of the quiz: ", questionNumber)
        }
    }
    
    func nextQuiz() {
        nextQuestion()
        self.presenter?.nextQuizState(nextQuiz: getNextQuiz(), currentProgress: getProgress(), currentScore: getScore(), bgColor: getBgColor(level: getNextQuiz().difficulty))
    }
}
