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
