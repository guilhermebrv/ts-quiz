//
//  ChooseDifficultyVC.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

class ChooseDifficultyVC: UIViewController {

    var chooseDifficulty: ChooseDifficultyView?
    
    override func loadView() {
        chooseDifficulty = ChooseDifficultyView()
        view = chooseDifficulty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPriorDifficulty()
        chooseDifficulty?.delegate(delegate: self)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func loadPriorDifficulty() {
        if TemporaryDataStorage.shared.difficultyLevel == "easy" {
            tappedEasyButton()
        } else if TemporaryDataStorage.shared.difficultyLevel == "intermediate" {
            tappedIntermediateButton()
        } else if TemporaryDataStorage.shared.difficultyLevel == "hard" {
            tappedHardButton()
        }
    }
}

extension ChooseDifficultyVC: ChooseDifficultyViewProtocol {
    func tappedEasyButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.chooseDifficulty?.easyButton.backgroundColor = .black
            self.chooseDifficulty?.intermediateButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.chooseDifficulty?.hardButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.chooseDifficulty?.nextButton.isEnabled = true
        }
        TemporaryDataStorage.shared.difficultyLevel = "easy"
    }
    
    func tappedIntermediateButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.chooseDifficulty?.intermediateButton.backgroundColor = .black
            self.chooseDifficulty?.easyButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.chooseDifficulty?.hardButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.chooseDifficulty?.nextButton.isEnabled = true
        }
        TemporaryDataStorage.shared.difficultyLevel = "intermediate"
    }
    
    func tappedHardButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.chooseDifficulty?.hardButton.backgroundColor = .black
            self.chooseDifficulty?.easyButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.chooseDifficulty?.intermediateButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.chooseDifficulty?.nextButton.isEnabled = true
        }
        TemporaryDataStorage.shared.difficultyLevel = "hard"
    }
    
    func tappedNextButton() {
        
        chooseDifficulty?.nextButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.chooseDifficulty?.nextButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        
        print("The chosen level was: \(TemporaryDataStorage.shared.difficultyLevel)")
        print("The player name is: \(TemporaryDataStorage.shared.playerName)")

        let nextScreen = ChooseEra2VC()
        self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    func tappedBackButton() {
        chooseDifficulty?.backButton.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 0.8)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.chooseDifficulty?.backButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        }
        navigationController?.popViewController(animated: true)
    }
}
