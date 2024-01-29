//
//  MainViewController.swift
//  Website filter
//
//  Created by Ivan Solohub on 28.01.2024.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
    private var appNameLabel = UILabel()
    private var searchingTextField = UITextField()
    private var webView = WKWebView()
    
    private var underscoreLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backgroundColor
        setupUI()
    }

    private func setupUI() {
        setupAppNameLabel()
        setupSearchingTextField()
        setupUnderscoreLine()
        
        setupWebView()
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
        
        setupIconViews()
        
        view.addSubview(searchingTextField)
        searchingTextField.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 100),
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
        view.addSubview(webView)
        webView.addConstraints(to_view: view, [
            .top(anchor: searchingTextField.bottomAnchor, constant: 16)
        ])
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchText = searchingTextField.text,
           let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://www.google.com/search?q=\(encodedText)") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return true
    }
}
