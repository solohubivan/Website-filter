//
//  UIViewController+KeyboardDismiss.swift
//  Website filter
//
//  Created by Ivan Solohub on 31.01.2024.
//

import UIKit

extension UIViewController {
    
    func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = .zero
    }
}
