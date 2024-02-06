//
//  MainView.swift
//  Website filter
//
//  Created by Ivan Solohub on 05.02.2024.
//

import UIKit
import WebKit

class MainView: UIView, WKNavigationDelegate {
    
    private var appNameLabel = UILabel()
    private var searchingTextField = UITextField()
    private var underscoreLine = UIView()
    private var webView = WKWebView()
    
    private var buttonsStackView = UIStackView()
    private var backButton = UIButton(type: .custom)
    private var forwardButton = UIButton(type: .custom)
    private var listButton = UIButton(type: .custom)
    private var addButton = UIButton(type: .custom)
    
    weak var presentingViewController: UIViewController?
    var showAlert: (() -> Void)?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        self.backgroundColor = UIColor.backgroundColor
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        setupAppNameLabel()
        setupSearchingTextField()
        setupUnderscoreLine()
        setupWebView()
        setupButtonsStackView()

        setupKeyboardDismissGesture()
    }
    
    private func setupAppNameLabel() {
        appNameLabel.text = Constants.titleLabelText
        appNameLabel.textColor = UIColor.black
        appNameLabel.font = UIFont(name: "Rubik-Medium", size: 28)
 
        addSubview(appNameLabel)
        appNameLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 60),
            .centerX(anchor: self.centerXAnchor, constant: .zero),
            .height(constant: 28)])
    }
    
    private func setupSearchingTextField() {
        searchingTextField.delegate = self
        searchingTextField.clearButtonMode = .whileEditing
        searchingTextField.placeholder = Constants.textFieldPlaceHolderText
        searchingTextField.overrideUserInterfaceStyle = .light
        
        setupIconViews()
        
        addSubview(searchingTextField)
        searchingTextField.addConstraints(to_view: self, [
            .top(anchor: appNameLabel.bottomAnchor, constant: 12),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .height(constant: 36)
        ])
    }

    private func setupIconViews() {
        let searchIconView = UIView(frame: CGRect(x: .zero, y: .zero, width: 36, height: 20))
        let searchImageView = UIImageView(image: UIImage(named: Constants.searchIconImageName))
        searchImageView.frame = CGRect(x: 10, y: .zero, width: 20, height: 20)
        
        searchIconView.addSubview(searchImageView)

        searchingTextField.leftView = searchIconView
        searchingTextField.leftViewMode = .always
    }

    private func setupUnderscoreLine() {
        underscoreLine.backgroundColor = UIColor.black
        
        addSubview(underscoreLine)
        underscoreLine.addConstraints(to_view: self, [
            .centerY(anchor: searchingTextField.bottomAnchor, constant: .zero),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .height(constant: 2)])
    }
    
    private func setupWebView() {
        webView.isHidden = true
        webView.navigationDelegate = self
        
        addSubview(webView)
        webView.addConstraints(to_view: self, [
            .top(anchor: searchingTextField.bottomAnchor, constant: 16),
            .bottom(anchor: self.bottomAnchor, constant: 60)
        ])
    }
    
    private func setupButtonsStackView() {
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.distribution = .equalSpacing
        
        createButton(buttonName: backButton, imageName: Constants.backButtonImageName, action: #selector(backButtonTapped))
        createButton(buttonName: forwardButton, imageName: Constants.forwardButtonImageName, action: #selector(forwardButtonTapped))
        createButton(buttonName: listButton, imageName: Constants.listButtonImageName, action: #selector(listButtonTapped))
        createButton(buttonName: addButton, imageName: Constants.addButtonImageName, action: #selector(addButtonTapped))
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false

        backButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: .zero, bottom: 22, right: .zero)
        forwardButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: .zero, bottom: 22, right: .zero)
        listButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: .zero, bottom: 22, right: .zero)
        addButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: .zero, bottom: 22, right: .zero)
        
        buttonsStackView.addArrangedSubview(backButton)
        buttonsStackView.addArrangedSubview(forwardButton)
        buttonsStackView.addArrangedSubview(listButton)
        buttonsStackView.addArrangedSubview(addButton)
        
        addSubview(buttonsStackView)
        buttonsStackView.addConstraints(to_view: self, [
            .top(anchor: webView.bottomAnchor, constant: .zero)
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
        let listRestrictionsVC = ListRestrictionsVC()
        listRestrictionsVC.modalPresentationStyle = .formSheet
        presentingViewController?.present(listRestrictionsVC, animated: true)
    }
    
    @objc private func addButtonTapped() {
        let addRestrictionVC = AddRestrictionVC()
        addRestrictionVC.modalPresentationStyle = .formSheet
        presentingViewController?.present(addRestrictionVC, animated: true)
    }
    
    // MARK: - Private methods
    
    private func createButton(buttonName: UIButton, imageName: String, action: Selector) {
        let buttonImage = UIImage(named: imageName)
        buttonName.setImage(buttonImage, for: .normal)
        buttonName.imageView?.contentMode = .scaleAspectFit
        buttonName.addTarget(self, action: action, for: .touchUpInside)
    }

    private func performSearchWithFiltering(_ searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else { return }

        let words = searchText.components(separatedBy: .whitespacesAndNewlines)
        let filteredWords = words.filter { word in
            !FiltersManager.shared.getActiveFilters().contains { filter in
                word.lowercased().contains(filter.filterString.lowercased())
            }
        }
        let filteredSearchText = filteredWords.joined(separator: " ")
        
        if !filteredSearchText.isEmpty {
            searchInGoogle(filteredSearchText)
        } else {
            showAlert?()
        }
    }

    private func searchInGoogle(_ query: String) {
        if let encodedText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://www.google.com/search?q=\(encodedText)") {
            let request = URLRequest(url: url)
            webView.load(request)
            webView.isHidden = false
            webView.allowsBackForwardNavigationGestures = true
            backButton.isEnabled = true
            forwardButton.isEnabled = true
        }
    }
}

// MARK: - TextField properties

extension MainView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            performSearchWithFiltering(textField.text)
            return true
    }
}

// MARK: - Constants

extension MainView {
    
    private enum Constants {
        
        static let titleLabelText: String = "Website filter"
        static let textFieldPlaceHolderText: String = "Tap to search"
        
        static let backButtonImageName: String = "arrowBack"
        static let forwardButtonImageName: String = "arrowForward"
        static let listButtonImageName: String = "listButton"
        static let addButtonImageName: String = "addButton"
        static let searchIconImageName: String = "searchIcon"
    }
}
