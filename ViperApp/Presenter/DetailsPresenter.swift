//
//  DetailsPresenter.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//
import Foundation

protocol DetailsPresenterProtocol: AnyObject {
    var view: DetailsViewProtocol? { get set }
    var interactor: DetailsInteractorProtocol? { get set }
    var router: DetailsRouterProtocol? { get set }
    func viewDidLoad()
    func didFetchUniversityDetails(_ university: University)
}

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    var interactor: DetailsInteractorProtocol?
    var router: DetailsRouterProtocol?
    
    func viewDidLoad() {
        interactor?.getUniversityDetails()
    }
    
    func didFetchUniversityDetails(_ university: University) {
        view?.showUniversityDetails(university)
    }
}
