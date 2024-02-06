//
//  ListRestrictions.swift
//  Website filter
//
//  Created by Ivan Solohub on 30.01.2024.
//

import UIKit

class ListRestrictionsVC: UIViewController {
    
    private lazy var listRestrictionView: ListRestrictionsView = ListRestrictionsView(frame: .zero)
    
    override func loadView() {
        view = listRestrictionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureListRestrictionView()
    }
    
    private func configureListRestrictionView() {
        listRestrictionView.onBackButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}

/*
import UIKit

class ListRestrictionsVC: UIViewController {
    
    private var titleLabel = UILabel()
    private var backToMainVCButton = UIButton(type: .system)
    private var separateLine = UIView()
    private var filterWordsTable = UITableView()
    
    var filters: [Filter] = []
    
    var onFilterRemoved: ((Filter) -> Void)?
    
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
        setupFilterWordsTable()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Current filters"
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
    
    private func setupFilterWordsTable() {
        filterWordsTable.dataSource = self
        filterWordsTable.delegate = self
        filterWordsTable.register(UITableViewCell.self, forCellReuseIdentifier: "filterWordsTableCellID")
        
        filterWordsTable.backgroundColor = .clear
        filterWordsTable.overrideUserInterfaceStyle = .light
        
        self.view.addSubview(filterWordsTable)
        filterWordsTable.addConstraints(to_view: view, [
            .top(anchor: separateLine.bottomAnchor, constant: 2)
        ])
        
        filterWordsTable.reloadData()
    }
    
}

// MARK: - Table properties

extension ListRestrictionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterWordsTableCellID", for: indexPath)
        let filter = filters[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: "SFProText-Regular", size: 18)
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
            let removedFilter = filters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            onFilterRemoved?(removedFilter)
            tableView.endUpdates()
        }
    }
}

*/
