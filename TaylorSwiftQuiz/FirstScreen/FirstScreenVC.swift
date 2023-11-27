//
//  FirstScreenVC.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

class FirstScreenVC: UIViewController {
    
    var firstScreenView: FirstScreenView?
    
    override func loadView() {
        firstScreenView = FirstScreenView()
        view = firstScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstScreenView?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstScreenView?.tappedimageAnimation()
        firstScreenView?.imageInitialAnimation()
    }
}

extension FirstScreenVC: FirstScreenViewProtocol {
    
    func tappedStartGameButton() {
        firstScreenView?.animateStartGameButton()
        firstScreenView?.tappedimageAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let secondscreen = SecondScreenVC()
            self.navigationController?.pushViewController(secondscreen, animated: true)
        }
    }
}
