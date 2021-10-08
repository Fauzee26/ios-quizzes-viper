//
//  MainPresenter.swift
//  learn-ios-viper
//
//  Created by Muhammad Hilmy Fauzi on 02/09/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    func quizSuccess(quizList: [Quiz])
    func quizFailed(error: String)
    
    func nextQuizState(nextQuiz: Quiz, currentProgress: Float, currentScore: Int, bgColor: UIColor, isFinished: Bool)
}

protocol MainPresenterViewProtocol: AnyObject {
    func onQuizResponseSuccess(quizList: [Quiz])
    func onQuizResponseFailed(error: String)
    
    func onNextQuestionPressed(nextQuiz: Quiz, currentProgress: Float, currentScore: Int, bgColor: UIColor, isFinished: Bool)
}

class MainPresenter: MainViewProtocol {
    var presenterView: MainPresenterViewProtocol?
    
    var interactor: MainInteractorProtocol?
    
    var router: MainRouterProtocol?
    
    func getData() {
        interactor?.loadData()
    }
    
    func resetState() {
        interactor?.resetStateInteractor()
    }
    
    func setQuizzes(list: [Quiz]) {
        interactor?.setListQuiz(quizzes: list)
    }
    
    func checkAnswer(userAnswer: String) -> Bool {
        return (interactor?.checkAnswer(userAnswer))!
    }
    
    func nextQuizPressed() {
        interactor?.nextQuiz()
    }
}

extension MainPresenter: MainPresenterProtocol {
    func nextQuizState(nextQuiz: Quiz, currentProgress: Float, currentScore: Int, bgColor: UIColor, isFinished: Bool) {
        presenterView?.onNextQuestionPressed(nextQuiz: nextQuiz, currentProgress: currentProgress, currentScore: currentScore, bgColor: bgColor, isFinished: isFinished)
    }
    
    func quizSuccess(quizList: [Quiz]) {
        presenterView?.onQuizResponseSuccess(quizList: quizList)
    }
    
    func quizFailed(error: String) {
        presenterView?.onQuizResponseFailed(error: error)
    }
}
