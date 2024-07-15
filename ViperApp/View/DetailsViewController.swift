//
//  DetailsViewController.swift
//  ViperApp
//
//  Created by Yasir Khan on 15/07/2024.
//

import UIKit
import WebKit

protocol DetailsViewProtocol: AnyObject {
    var presenter: DetailsPresenterProtocol? { get set }
    func showUniversityDetails(_ university: University)
}

class DetailsViewController: UIViewController, DetailsViewProtocol, WKNavigationDelegate {
    var presenter: DetailsPresenterProtocol?

    private let nameLabel = UILabel()
    private let countryLabel = UILabel()
    private let webView = WKWebView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter?.viewDidLoad()
    }

    private func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [nameLabel, countryLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true

        view.addSubview(stackView)
        view.addSubview(webView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            webView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func showUniversityDetails(_ university: University) {
        print("View: Show university details")
        nameLabel.text = "Name: \(university.name)"
        countryLabel.text = "Country: \(university.country)"
        
        if let url = URL(string: university.webPage) {
            let request = URLRequest(url: url)
            webView.load(request)
            activityIndicator.startAnimating()
        }
    }

    // WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        // Optionally, show an error message
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
}
