//
//  MainViewController.swift
//  Website filter
//
//  Created by Ivan Solohub on 28.01.2024.
//

import UIKit
import WebKit

class MainViewController: UIViewController, WKNavigationDelegate {
    
    private var appNameLabel = UILabel()
    private var searchingTextField = UITextField()
    private var underscoreLine = UIView()
    private var webView = WKWebView()
    
    private var buttonsStackView = UIStackView()
    private var backButton = UIButton(type: .custom)
    private var forwardButton = UIButton(type: .custom)
    private var listButton = UIButton(type: .custom)
    private var addButton = UIButton(type: .custom)
    
    var filters: [Filter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backgroundColor
        setupUI()
        checkInternetConnection()
    }
    
    // MARK: - Setup UI

    private func setupUI() {
        setupAppNameLabel()
        setupSearchingTextField()
        setupUnderscoreLine()
        setupWebView()
        setupButtonsStackView()
        
        setupKeyboardDismissGesture()
    }
    
    private func setupAppNameLabel() {
        appNameLabel.text = "Website filter"
        appNameLabel.textColor = UIColor.black
        appNameLabel.font = UIFont(name: "Rubik-Medium", size: 28)
 
        view.addSubview(appNameLabel)
        appNameLabel.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 60),
            .centerX(anchor: view.centerXAnchor, constant: 0),
            .height(constant: 28)])
    }
    
    private func setupSearchingTextField() {
        searchingTextField.delegate = self
        searchingTextField.clearButtonMode = .whileEditing
        searchingTextField.placeholder = "Tap to search"
        searchingTextField.overrideUserInterfaceStyle = .light
        
        setupIconViews()
        
        view.addSubview(searchingTextField)
        searchingTextField.addConstraints(to_view: view, [
            .top(anchor: appNameLabel.bottomAnchor, constant: 12),
            .leading(anchor: view.leadingAnchor, constant: 16),
            .trailing(anchor: view.trailingAnchor, constant: 16),
            .height(constant: 36)
        ])
    }
    
    private func setupIconViews() {
        let searchIconView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 20))
        let searchImageView = UIImageView(image: UIImage(named: "searchIcon"))
        searchImageView.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        
        searchIconView.addSubview(searchImageView)

        searchingTextField.leftView = searchIconView
        searchingTextField.leftViewMode = .always
    }
    
    private func setupUnderscoreLine() {
        underscoreLine.backgroundColor = UIColor.black
        
        view.addSubview(underscoreLine)
        underscoreLine.addConstraints(to_view: view, [
            .centerY(anchor: searchingTextField.bottomAnchor, constant: 0),
            .leading(anchor: view.leadingAnchor, constant: 16),
            .trailing(anchor: view.trailingAnchor, constant: 16),
            .height(constant: 2)])
    }
    
    private func setupWebView() {
        webView.isHidden = true
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        webView.addConstraints(to_view: view, [
            .top(anchor: searchingTextField.bottomAnchor, constant: 16),
            .bottom(anchor: view.bottomAnchor, constant: 60)
        ])
    }
    
    private func setupButtonsStackView() {
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .equalSpacing
        
        createButton(buttonName: backButton, imageName: "arrowBack", action: #selector(backButtonTapped))
        createButton(buttonName: forwardButton, imageName: "arrowForward", action: #selector(forwardButtonTapped))
        createButton(buttonName: listButton, imageName: "listButton", action: #selector(listButtonTapped))
        createButton(buttonName: addButton, imageName: "addButton", action: #selector(addButtonTapped))
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        backButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 22, right: 0)
        forwardButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 22, right: 0)
        listButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 22, right: 0)
        addButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 22, right: 0)
        
        buttonsStackView.addArrangedSubview(backButton)
        buttonsStackView.addArrangedSubview(forwardButton)
        buttonsStackView.addArrangedSubview(listButton)
        buttonsStackView.addArrangedSubview(addButton)
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addConstraints(to_view: view, [
            .top(anchor: webView.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - buttons selectors
    
    @objc private func backButtonTapped() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc private func forwardButtonTapped() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @objc private func listButtonTapped() {
        let listRestrictions = ListRestrictionsVC()
        listRestrictions.modalPresentationStyle = .formSheet
        
        listRestrictions.filters = self.filters
        
        listRestrictions.onFilterRemoved = { [weak self] removedFilter in
            if let index = self?.filters.firstIndex(of: removedFilter) {
                self?.filters.remove(at: index)
            }
        }
        
        present(listRestrictions, animated: true)
    }
    
    @objc private func addButtonTapped() {
        let addRestrictionVC = AddRestrictionVC()
        addRestrictionVC.modalPresentationStyle = .formSheet
        
        addRestrictionVC.onFilterAdded = { [weak self] filter in
            self?.filters.append(filter)
        }
        
        present(addRestrictionVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func createButton(buttonName: UIButton, imageName: String, action: Selector) {
        let buttonImage = UIImage(named: imageName)
        buttonName.setImage(buttonImage, for: .normal)
        buttonName.imageView?.contentMode = .scaleAspectFit
        buttonName.addTarget(self, action: action, for: .touchUpInside)
    }

    private func searchingGoogle() {
        guard let searchText = searchingTextField.text else { return }
        let words = searchText.components(separatedBy: .whitespacesAndNewlines)

        let filteredWords = words.filter { word in
            !filters.contains { filter in word.lowercased().contains(filter.filterString.lowercased()) }
        }
        let filteredSearchText = filteredWords.joined(separator: " ")

        if !filteredSearchText.isEmpty {
            if let encodedText = filteredSearchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: "https://www.google.com/search?q=\(encodedText)") {
                let request = URLRequest(url: url)
                webView.load(request)
                webView.isHidden = false
                webView.allowsBackForwardNavigationGestures = true
                backButton.isEnabled = true
                forwardButton.isEnabled = true
            }
        } else {
            requestFullFilteredAlert()
        }
    }

    private func isURLFiltered(_ url: URL) -> Bool {
        let urlString = url.absoluteString.lowercased()
        return filters.contains { filter in
            return urlString.contains(filter.filterString.lowercased())
        }
    }
    
    private func checkInternetConnection() {
        if !NetworkMonitor.shared.isConnected {
            DispatchQueue.main.async {
                self.showNoInternetAlert()
            }
        }
    }
    
    // MARK: - Alerts
    
    private func requestFullFilteredAlert() {
        let cancelAction = AlertFactory.createAlertAction(
            title: "Cancel",
            style: .cancel
        )
        let alertController = AlertFactory.createAlert(
            title: "All your request is filtered",
            message: "Please customize filters or change request",
            actions: [cancelAction]
        )

        present(alertController, animated: true, completion: nil)
    }

    private func showNoInternetAlert() {
        let cancelAction = AlertFactory.createAlertAction(
            title: "Cancel",
            style: .cancel
        )
        let settingsAction = AlertFactory.createAlertAction(
            title: "Settings",
            style: .default
        ) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }

        let alertController = AlertFactory.createAlert(
            title: "Internet connection is unavailable",
            message: "please allow this app to internet access",
            actions: [cancelAction, settingsAction]
        )

        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Textfield properties

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        searchingGoogle()

        return true
    }
}
