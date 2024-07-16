//
//  ListingInteractor.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//
import Foundation
import RealmSwift

protocol ListingInteractorProtocol: AnyObject {
    var presenter: ListingPresenterProtocol? { get set }
    func fetchUniversities()
}

class ListingInteractor: ListingInteractorProtocol {
    weak var presenter: ListingPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    private let databaseService: DatabaseServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService(), databaseService: DatabaseServiceProtocol = DatabaseService()) {
        self.networkService = networkService
        self.databaseService = databaseService
    }

    func fetchUniversities() {
        networkService.fetchUniversities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let universities):
                    self?.databaseService.saveUniversities(universities)
                    self?.presenter?.didFetchUniversities(universities)
                case .failure(let error):
                    self?.fetchUniversitiesFromDatabase(with: error.localizedDescription)
                }
            }
        }
    }

    private func fetchUniversitiesFromDatabase(with errorMessage: String) {
        let universities = databaseService.fetchUniversities()
        if universities.isEmpty {
            presenter?.didFailToFetchUniversities(errorMessage)
        } else {
            presenter?.didFetchUniversities(universities)
        }
    }
}
