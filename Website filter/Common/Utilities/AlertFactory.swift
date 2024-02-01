//
//  AlertFactory.swift
//  Website filter
//
//  Created by Ivan Solohub on 01.02.2024.
//

import UIKit

class AlertFactory {

    static func createAlert(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        return alertController
    }

    static func createAlertAction(
        title: String,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}
