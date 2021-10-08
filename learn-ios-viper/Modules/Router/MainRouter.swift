//
//  MainRouter.swift
//  learn-ios-viper
//
//  Created by Muhammad Hilmy Fauzi on 02/09/20.
//  Copyright © 2020 Muhammad Hilmy Fauzi. All rights reserved.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    static func setupProtocolView(mainVC: MainVC)
}

class MainRouter: MainRouterProtocol {
    static func setupProtocolView(mainVC: MainVC) {
        let presenter: MainViewProtocol & MainPresenterProtocol = MainPresenter()
        
        mainVC.presenter = presenter
        mainVC.presenter?.router = MainRouter()
        mainVC.presenter?.presenterView = mainVC
        mainVC.presenter?.interactor = MainInteractor()
        mainVC.presenter?.interactor?.presenter = presenter
    }
}
