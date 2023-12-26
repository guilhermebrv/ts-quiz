//
//  UIViewController + Extension.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/12/2023.
//

import UIKit

extension UIViewController {
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    public func tappedButtonEffect(button: UIButton) {
        button.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
    }
}

