//
//  UIViewExtension.swift
//  Website filter
//
//  Created by Ivan Solohub on 28.01.2024.
//

import UIKit
import CoreImage

enum ConstraintType {
    case top(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case leading(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case bottom(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case trailing(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
    case width(constant: CGFloat)
    case height(constant: CGFloat)
    case centerY(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0)
    case centerX(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0)
}

/// This method simplifies the process of adding constraints.
///
/// To use this method, call  `object.addConstraints(view)` . This will pin 'object' to the `leading, trailing, bottom and top anchors of 'view'.`
///
/// To add custom constraints, use the following syntax:
///
/// `object.addConstraints(view, [
///  `.top(someObject.bottomAnchor), // constant is 0
///  `.leading(someObject.trailingAnchor, constant: 30)
/// `])
///
/// The above example will pin 'object' with both custom constraints and default values: `view.trailingAnchor` with a constant of 0 and `view.bottomAnchor` with a constant of 0.
/// If you use the `height` parameter, the default `view` `top` and `bottom` anchors will not be automatically called.
/// If you use the `width` parameter, the default `view` `leading` and `trailing` anchors will not be automatically called.
/// The same applies to `centerXAnchorConstraint` and `centerYAnchorConstraint`.

extension UIView {
    func addConstraints(to_view view: UIView, _ constraints: [ConstraintType] = []) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var topAnchorConstraint: NSLayoutConstraint?
        var leadingAnchorConstraint: NSLayoutConstraint?
        var bottomAnchorConstraint: NSLayoutConstraint?
        var trailingAnchorConstraint: NSLayoutConstraint?
        var widthAnchorConstraint: NSLayoutConstraint?
        var heightAnchorConstraint: NSLayoutConstraint?
        var centerXAnchorConstraint: NSLayoutConstraint?
        var centerYAnchorConstraint: NSLayoutConstraint?
        
        for constraint in constraints {
            switch constraint {
            case .top(let anchor, let constant):
                topAnchorConstraint = topAnchor.constraint(equalTo: anchor, constant: constant)
                topAnchorConstraint?.isActive = true
            case .leading(let anchor, let constant):
                leadingAnchorConstraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
                leadingAnchorConstraint?.isActive = true
            case .bottom(let anchor, let constant):
                bottomAnchorConstraint = bottomAnchor.constraint(equalTo: anchor, constant: -constant)
                bottomAnchorConstraint?.isActive = true
            case .trailing(let anchor, let constant):
                trailingAnchorConstraint = trailingAnchor.constraint(equalTo: anchor, constant: -constant)
                trailingAnchorConstraint?.isActive = true
            case .width(let constant):
                widthAnchorConstraint = widthAnchor.constraint(equalToConstant: constant)
                widthAnchorConstraint?.isActive = true
            case .height(let constant):
                heightAnchorConstraint = heightAnchor.constraint(equalToConstant: constant)
                heightAnchorConstraint?.isActive = true
            case .centerY(let anchor, let constant):
                centerYAnchorConstraint = centerYAnchor.constraint(equalTo: anchor, constant: constant)
                centerYAnchorConstraint?.isActive = true
            case .centerX(let anchor, let constant):
                centerXAnchorConstraint = centerXAnchor.constraint(equalTo: anchor, constant: constant)
                centerXAnchorConstraint?.isActive = true
            }
        }
        
        if topAnchorConstraint == nil && heightAnchorConstraint == nil && centerYAnchorConstraint == nil {
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        if leadingAnchorConstraint == nil && widthAnchorConstraint == nil && centerXAnchorConstraint == nil {
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        }
        
        if bottomAnchorConstraint == nil && heightAnchorConstraint == nil && centerYAnchorConstraint == nil {
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        if trailingAnchorConstraint == nil && widthAnchorConstraint == nil && centerXAnchorConstraint == nil {
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y = .zero
    }
}
