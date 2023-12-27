//
//  UIView + Extension.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/12/2023.
//

import UIKit

extension UIView {
    public func pin(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
}
