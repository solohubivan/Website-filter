//
//  AddRestrictionView.swift
//  Website filter
//
//  Created by Ivan Solohub on 05.02.2024.
//

import UIKit

class AddRestrictionView: UIView {
    
    private var titleLabel = UILabel()
    private var backToMainVCButton = UIButton(type: .system)
    private var separateLine = UIView()
    private var inputRestrictionTF = UITextField()
    
    var onBackButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupBlurBackgroundColor()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupBlurBackgroundColor() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = self.bounds
        self.insertSubview(blurEffectView, at: .zero)
    }
    
    private func setupUI() {
        setupTitleLabel()
        setupBackToMainVCButton()
        setupSeparateLine()
        setupInputRestrictionTF()
        
        setupKeyboardDismissGesture()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Constants.titleLabelText
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: Constants.sFProTextSemiboldFont, size: 20)
        
        self.addSubview(titleLabel)
        titleLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .centerX(anchor: self.centerXAnchor, constant: 0),
            .height(constant: 20)
        ])
    }
    
    private func setupBackToMainVCButton() {
        backToMainVCButton.setTitle(Constants.titleButtonBack, for: .normal)
        backToMainVCButton.setImage(UIImage(systemName: Constants.backButtonImageName), for: .normal)
        backToMainVCButton.tintColor = .blue
        backToMainVCButton.titleLabel?.font = UIFont(name: Constants.sFProTextRegularFont, size: 18)
        backToMainVCButton.contentHorizontalAlignment = .left
        
        backToMainVCButton.addTarget(self, action: #selector(backToMainVCButtonTapped), for: .touchUpInside)
        
        self.addSubview(backToMainVCButton)
        backToMainVCButton.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .height(constant: 20),
            .trailing(anchor: titleLabel.leadingAnchor, constant: 10)
        ])
    }

    @objc private func backToMainVCButtonTapped() {
        onBackButtonTapped?()
    }

    private func setupSeparateLine() {
        separateLine.backgroundColor = UIColor.lightGray
        
        self.addSubview(separateLine)
        separateLine.addConstraints(to_view: self, [
            .top(anchor: titleLabel.bottomAnchor, constant: 11),
            .height(constant: 1)
        ])
    }
    
    private func setupInputRestrictionTF() {
        inputRestrictionTF.delegate = self
        inputRestrictionTF.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: 10, height: Int(inputRestrictionTF.frame.height)))
        inputRestrictionTF.leftViewMode = .always
        inputRestrictionTF.layer.borderColor = UIColor.lightGray.cgColor
        inputRestrictionTF.layer.borderWidth = 1
        inputRestrictionTF.layer.cornerRadius = 12
        inputRestrictionTF.backgroundColor = UIColor.textFieldbackgroundColor
        inputRestrictionTF.placeholder = Constants.textFieldPlaceHolderText
        inputRestrictionTF.overrideUserInterfaceStyle = .light
        
        self.addSubview(inputRestrictionTF)
        inputRestrictionTF.addConstraints(to_view: self, [
            .top(anchor: separateLine.bottomAnchor, constant: 20),
            .leading(anchor: self.leadingAnchor, constant: 16),
            .trailing(anchor: self.trailingAnchor, constant: 16),
            .height(constant: 40)
        ])
    }
}

// MARK: - Textfield properties

extension AddRestrictionView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let filter = Filter(filterString: textField.text!)
        FiltersManager.shared.addFilter(filter)
        inputRestrictionTF.text = ""
        return true
    }
}

// MARK: - Constants

extension AddRestrictionView {
    
    private enum Constants {
        
        static let titleLabelText: String = "Add filter"
        static let titleButtonBack: String = "Back"
        static let textFieldPlaceHolderText: String = "Input here words for filtering"
        
        static let sFProTextSemiboldFont: String = "SFProText-Semibold"
        static let sFProTextRegularFont: String = "SFProText-Regular"
        
        static let backButtonImageName: String = "chevron.backward"
    }
}
