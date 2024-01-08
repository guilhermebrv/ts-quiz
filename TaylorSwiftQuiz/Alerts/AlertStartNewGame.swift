//
//  AlertStartNewGame.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 08/01/2024.
//

import UIKit

class AlertStartNewGame {
	private let controller: UIViewController
	
	init(controller: UIViewController) {
		self.controller = controller
	}
	
	public func showAlert(title: String, message: String, confirm: @escaping () -> Void) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
			confirm()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		
		alertController.addAction(confirmAction)
		alertController.addAction(cancelAction)
		
		controller.present(alertController, animated: true)
	}
}
