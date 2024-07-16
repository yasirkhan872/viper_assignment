//
//  NetworkProtocols.swift
//  ViperApp
//
//  Created by Yasir Khan on 16/07/2024.
//

import Foundation
protocol NetworkServiceProtocol {
    func fetchUniversities(completion: @escaping (Result<[University], Error>) -> Void)
}

protocol DatabaseServiceProtocol {
    func saveUniversities(_ universities: [University])
    func fetchUniversities() -> [University]
}
