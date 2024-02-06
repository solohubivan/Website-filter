//
//  ListRestrictionsView.swift
//  Website filter
//
//  Created by Ivan Solohub on 05.02.2024.
//

import UIKit

class ListRestrictionsView: UIView {
    
    private var titleLabel = UILabel()
    private var backToMainVCButton = UIButton(type: .system)
    private var separateLine = UIView()
    private var filterWordsTable = UITableView()
    
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
        setupFilterWordsTable()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Constants.titleLabelText
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: Constants.sFProTextSemiboldFont, size: 20)
        
        self.addSubview(titleLabel)
        titleLabel.addConstraints(to_view: self, [
            .top(anchor: self.topAnchor, constant: 20),
            .centerX(anchor: self.centerXAnchor, constant: .zero),
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
    
    private func setupFilterWordsTable() {
        filterWordsTable.dataSource = self
        filterWordsTable.delegate = self
        filterWordsTable.register(UITableViewCell.self, forCellReuseIdentifier: Constants.filterWordsTableCellID)
        
        filterWordsTable.backgroundColor = .clear
        filterWordsTable.overrideUserInterfaceStyle = .light
        
        self.addSubview(filterWordsTable)
        filterWordsTable.addConstraints(to_view: self, [
            .top(anchor: separateLine.bottomAnchor, constant: 2)
        ])
        
        filterWordsTable.reloadData()
    }
}

// MARK: - TableView properties

extension ListRestrictionsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FiltersManager.shared.getActiveFiltersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.filterWordsTableCellID, for: indexPath)
        let filter = FiltersManager.shared.getActiveFilters()[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: Constants.sFProTextRegularFont, size: 18)
        cell.textLabel?.text = filter.filterString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            tableView.beginUpdates()
            FiltersManager.shared.removeFilter(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - Constants

extension ListRestrictionsView {
    
    private enum Constants {
        
        static let titleLabelText: String = "Current filters"
        static let titleButtonBack: String = "Back"
        
        static let sFProTextSemiboldFont: String = "SFProText-Semibold"
        static let sFProTextRegularFont: String = "SFProText-Regular"
        
        static let backButtonImageName: String = "chevron.backward"
        
        static let filterWordsTableCellID: String = "filterWordsTableCellID"
    }
}
