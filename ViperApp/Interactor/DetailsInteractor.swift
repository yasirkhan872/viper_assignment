//
//  DetailsInteractor.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import Foundation

protocol DetailsInteractorProtocol: AnyObject {
    var presenter: DetailsPresenterProtocol? { get set }
    func getUniversityDetails()
}

class DetailsInteractor: DetailsInteractorProtocol {
    weak var presenter: DetailsPresenterProtocol?
    private var university: University

    init(university: University) {
        self.university = university
    }

    func getUniversityDetails() {
        presenter?.didFetchUniversityDetails(university)
    }
}
