//
//  AddRestrictionVC.swift
//  Website filter
//
//  Created by Ivan Solohub on 30.01.2024.
//

import UIKit

class AddRestrictionVC: UIViewController {
    
    private lazy var addRestrictionView: AddRestrictionView = AddRestrictionView(frame: .zero)
    
    override func loadView() {
        view = addRestrictionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddRestrictionView()
    }
    
    private func configureAddRestrictionView() {
        addRestrictionView.onBackButtonTapped = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
