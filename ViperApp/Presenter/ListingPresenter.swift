//
//  ListingPresenter.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import Foundation

protocol ListingPresenterProtocol: AnyObject {
    var view: ListingViewProtocol? { get set }
    var interactor: ListingInteractorProtocol? { get set }
    var router: ListingRouterProtocol? { get set }
    func viewDidLoad()
    func refreshData()
    func didSelectUniversity(_ university: University)
    func didFetchUniversities(_ universities: [University])
    func didFailToFetchUniversities(_ error: String)
}

class ListingPresenter: ListingPresenterProtocol {
    weak var view: ListingViewProtocol?
    var interactor: ListingInteractorProtocol?
    var router: ListingRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchUniversities()
    }
    
    func refreshData() {
        interactor?.fetchUniversities()
    }
    
    func didSelectUniversity(_ university: University) {
        router?.navigateToDetailsScreen(with: university)
    }
    
    func didFetchUniversities(_ universities: [University]) {
        view?.showUniversities(universities)
    }
    
    func didFailToFetchUniversities(_ error: String) {
        view?.showError(error)
    }
}
