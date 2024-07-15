//
//  ListingViewController.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import Foundation
import UIKit

protocol ListingViewProtocol: AnyObject {
    var presenter: ListingPresenterProtocol? { get set }
    func showUniversities(_ universities: [University])
    func showError(_ message: String)
}

class ListingViewController: UIViewController, ListingViewProtocol {
    var presenter: ListingPresenterProtocol?

    private var universities: [University] = []
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Universities"
        setupTableView()
        setupRefreshButton()
        presenter?.viewDidLoad()
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }

    private func setupRefreshButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshTapped)
        )
    }

    @objc private func refreshTapped() {
        presenter?.refreshData()
    }

    func showUniversities(_ universities: [University]) {
        self.universities = universities
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let university = universities[indexPath.row]
        cell.textLabel?.text = university.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let university = universities[indexPath.row]
        presenter?.didSelectUniversity(university)
    }
}
