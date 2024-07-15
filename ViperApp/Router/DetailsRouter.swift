//
//  DetailsRouter.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import UIKit

// Protocol defining the router's responsibilities, including creating the module with a University object
protocol DetailsRouterProtocol: AnyObject {
    static func createModule(with university: University) -> UIViewController
}

// Implementation of the router for the Details module
class DetailsRouter: DetailsRouterProtocol {
    // Static method to create and configure the Details module with a University object
    static func createModule(with university: University) -> UIViewController {
        let view = DetailsViewController() // Initialize view
        let presenter: DetailsPresenterProtocol = DetailsPresenter() // Initialize presenter
        let interactor: DetailsInteractorProtocol = DetailsInteractor(university: university) // Initialize interactor with university data
        let router: DetailsRouterProtocol = DetailsRouter() // Initialize router
        
        // Connect VIPER components
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view // Return the configured view controller
    }
}
