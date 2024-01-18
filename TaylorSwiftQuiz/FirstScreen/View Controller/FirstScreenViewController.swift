//
//  FirstScreenViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

class FirstScreenViewController: UIViewController {
    private var screen: FirstScreenView?
    
    override func loadView() {
        screen = FirstScreenView()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
		UserDataModel.shared.resetCoreDataContainer()
        tappedImageAnimation()
        imageInitialAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
    }
    
    private func signProtocols() {
        screen?.delegate(delegate: self)
    }
}

extension FirstScreenViewController: FirstScreenViewProtocol {
    internal func tappedStartGameButton() {
        animateStartGameButton()
        tappedImageAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let playerDetails = PlayerDetailsViewController()
            self.navigationController?.pushViewController(playerDetails, animated: true)
        }
    }
    private func animateStartGameButton() {
        screen?.startGameButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.screen?.startGameButton.backgroundColor = .bgGreen
        }
    }
    private func tappedImageAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.screen?.imageView.frame.origin.x += 300
        }
    }
    private func imageInitialAnimation() {
        screen?.nameLabel.alpha = 0.0
        screen?.name2Label.alpha = 0.0
        screen?.imageView.alpha = 0.0
        screen?.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1.5) {
            self.screen?.imageView.alpha = 1.0
            self.screen?.nameLabel.alpha = 1.0
            self.screen?.imageView.transform = CGAffineTransform.identity
        }
        UIView.animate(withDuration: 2.5) {
            self.screen?.name2Label.alpha = 1.0
        }
    }
}
