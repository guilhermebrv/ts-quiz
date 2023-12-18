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
        screen?.tappedimageAnimation()
        screen?.imageInitialAnimation()
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
    func tappedStartGameButton() {
        screen?.animateStartGameButton()
        screen?.tappedimageAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let secondscreen = SecondScreenVC()
            self.navigationController?.pushViewController(secondscreen, animated: true)
        }
    }
}
