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
    
    private let realm = try! Realm()

    func fetchUniversities() {
        let url = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.fetchUniversitiesFromDatabase(with: error.localizedDescription)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.fetchUniversitiesFromDatabase(with: "No data received from the API")
                }
                return
            }
            do {
                let universities = try JSONDecoder().decode([University].self, from: data)
                DispatchQueue.main.async {
                    self?.saveToDatabase(universities)
                    self?.presenter?.didFetchUniversities(universities)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.fetchUniversitiesFromDatabase(with: error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    private func saveToDatabase(_ universities: [University]) {
        try! realm.write {
            realm.add(universities, update: .modified)
        }
    }

    private func fetchUniversitiesFromDatabase(with errorMessage: String) {
        let universities = realm.objects(University.self)
        if universities.isEmpty {
            presenter?.didFailToFetchUniversities(errorMessage)
        } else {
            presenter?.didFetchUniversities(Array(universities))
        }
    }
}
