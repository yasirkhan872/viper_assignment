//
//  ListingRouter.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import UIKit

// Protocol defining the router's responsibilities, including creating the module and navigating to the details screen
protocol ListingRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToDetailsScreen(with university: University)
}

// Implementation of the router for the Listing module
class ListingRouter: ListingRouterProtocol {
    weak var viewController: UIViewController? // Weak reference to avoid retain cycles

    // Static method to create and configure the Listing module
    static func createModule() -> UIViewController {
        let view = ListingViewController() // Initialize view
        let presenter: ListingPresenterProtocol = ListingPresenter() // Initialize presenter
        let interactor: ListingInteractorProtocol = ListingInteractor() // Initialize interactor
        let router = ListingRouter() // Initialize router
        
        // Connect VIPER components
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        // Embed in navigation controller and set viewController reference
        let navigationController = UINavigationController(rootViewController: view)
        router.viewController = view
        
        return navigationController // Return the configured module
    }

    // Method to navigate to the details screen, passing the selected university
    func navigateToDetailsScreen(with university: University) {
        let detailsViewController = DetailsRouter.createModule(with: university) // Create details module
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true) // Navigate to details screen
    }
}


