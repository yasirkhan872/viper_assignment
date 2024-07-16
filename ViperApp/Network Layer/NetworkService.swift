//
//  NetworkService.swift
//  ViperApp
//
//  Created by Yasir Khan on 16/07/2024.
//

import Foundation
import RealmSwift

class NetworkService: NetworkServiceProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void) {
        let url = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received from the API"])
                completion(.failure(error))
                return
            }
            do {
                let universities = try JSONDecoder().decode([University].self, from: data)
                completion(.success(universities))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

class DatabaseService: DatabaseServiceProtocol {
    private let realm = try! Realm()

    func saveUniversities(_ universities: [University]) {
        try! realm.write {
            realm.add(universities, update: .modified)
        }
    }

    func fetchUniversities() -> [University] {
        return Array(realm.objects(University.self))
    }
}
