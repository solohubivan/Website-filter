//
//  AddRestrictionVC.swift
//  Website filter
//
//  Created by Ivan Solohub on 30.01.2024.
//

import UIKit

class AddRestrictionVC: UIViewController {
    
    private var titleLabel = UILabel()
    private var backToMainVCButton = UIButton(type: .system)
    private var separateLine = UIView()
    private var inputRestrictionTF = UITextField()
    
    var onFilterAdded: ((Filter) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBlurBackgroundColor()
        setupUI()
    }
    
    private func setupBlurBackgroundColor() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        setupTitleLabel()
        setupBackToMainVCButton()
        setupSeparateLine()
        setupInputRestrictionTF()
        
        setupKeyboardDismissGesture()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Add filter"
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "SFProText-Semibold", size: 20)
        
        self.view.addSubview(titleLabel)
        titleLabel.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 20),
            .centerX(anchor: view.centerXAnchor, constant: 0),
            .height(constant: 20)
        ])
    }
    
    private func setupBackToMainVCButton() {
        backToMainVCButton.setTitle("Back", for: .normal)
        backToMainVCButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backToMainVCButton.tintColor = .blue
        backToMainVCButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 18)
        backToMainVCButton.contentHorizontalAlignment = .left
        
        backToMainVCButton.addTarget(self, action: #selector(backToMainVCButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(backToMainVCButton)
        backToMainVCButton.addConstraints(to_view: view, [
            .top(anchor: view.topAnchor, constant: 20),
            .leading(anchor: view.leadingAnchor, constant: 16),
            .height(constant: 20),
            .trailing(anchor: titleLabel.leadingAnchor, constant: 10)
        ])
    }
    
    @objc private func backToMainVCButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    private func setupSeparateLine() {
        separateLine.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(separateLine)
        separateLine.addConstraints(to_view: view, [
            .top(anchor: titleLabel.bottomAnchor, constant: 11),
            .height(constant: 1)
        ])
    }
    
    private func setupInputRestrictionTF() {
        inputRestrictionTF.delegate = self
        inputRestrictionTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: Int(inputRestrictionTF.frame.height)))
        inputRestrictionTF.leftViewMode = .always
        inputRestrictionTF.layer.borderColor = UIColor.lightGray.cgColor
        inputRestrictionTF.layer.borderWidth = 1
        inputRestrictionTF.layer.cornerRadius = 12
        inputRestrictionTF.backgroundColor = UIColor.backgroundColor
        inputRestrictionTF.placeholder = "Input here words for filtering"
        
        self.view.addSubview(inputRestrictionTF)
        inputRestrictionTF.addConstraints(to_view: view, [
            .top(anchor: separateLine.bottomAnchor, constant: 20),
            .leading(anchor: view.leadingAnchor, constant: 16),
            .trailing(anchor: view.trailingAnchor, constant: 16),
            .height(constant: 40)
        ])
    }
    
    // MARK: - Private methods
    
    private func addRestrictions() {
        if let filterString = inputRestrictionTF.text, !filterString.isEmpty {
            let filter = Filter(filterString: filterString)
            onFilterAdded?(filter)
            inputRestrictionTF.text = ""
        }
    }
}

// MARK: - Textfield properties

extension AddRestrictionVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        addRestrictions()
        return true
    }
}
