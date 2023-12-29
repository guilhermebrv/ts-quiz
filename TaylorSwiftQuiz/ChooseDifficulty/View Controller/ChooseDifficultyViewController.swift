//
//  ChooseDifficultyViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

class ChooseDifficultyViewController: UIViewController {

    private var screen: ChooseDifficultyView?
    private let viewModel: ChooseDifficultyViewModel = ChooseDifficultyViewModel()
    
    override func loadView() {
        screen = ChooseDifficultyView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
        //loadPriorDifficulty()
    }
}

extension ChooseDifficultyViewController {
    private func signProtocols() {
        screen?.delegate(delegate: self)
    }
    /*
    private func loadPriorDifficulty() {
        if TemporaryDataStorage.shared.difficultyLevel == "easy" {
            tappedEasyButton()
        } else if TemporaryDataStorage.shared.difficultyLevel == "intermediate" {
            tappedIntermediateButton()
        } else if TemporaryDataStorage.shared.difficultyLevel == "hard" {
            tappedHardButton()
        }
    }
    */
}

extension ChooseDifficultyViewController: ChooseDifficultyViewProtocol {
    func tappedButton(difficulty: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.screen?.easyButton.backgroundColor = difficulty == "easy" ? .black : .customWhite
            self.screen?.intermediateButton.backgroundColor = difficulty == "intermediate" ? .black : .customWhite
            self.screen?.hardButton.backgroundColor = difficulty == "hard" ? .black : .customWhite
            self.screen?.nextButton.isEnabled = true
        }
        //viewModel.saveDifficulty(difficulty)
    }
    
    func tappedEasyButton() {
        tappedButton(difficulty: "easy")
        viewModel.saveDifficulty("easy")
    }
    
    func tappedIntermediateButton() {
        tappedButton(difficulty: "intermediate")
    }
    
    func tappedHardButton() {
        tappedButton(difficulty: "hard")
    }
    
    func tappedNextButton() {
        if let button = screen?.nextButton {
            tappedButtonEffect(button: button)
        }
        let nextScreen = ChooseEraViewController()
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    func tappedBackButton() {
        if let button = screen?.backButton {
            tappedButtonEffect(button: button)
        }
        navigationController?.popViewController(animated: true)
    }
}
