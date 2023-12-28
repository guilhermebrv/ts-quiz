//
//  QuestionsViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

class QuestionsViewController: UIViewController {
    var currentIndex: Int = 0
    private var screen: QuestionsView?
    private var viewModel: QuestionsViewModel = QuestionsViewModel()
    
    override func loadView() {
        screen = QuestionsView()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
        loadQuestion()
    }
}

extension QuestionsViewController {
    private func signProtocols() {
        screen?.delegate(delegate: self)
    }
    private func loadQuestion() {
        screen?.questionNumberLabel.text = "Question \(TemporaryDataStorage.shared.currentQuestion)"
        screen?.firstOptionButton.isEnabled = true
        screen?.secondOptionButton.isEnabled = true
        screen?.thirdOptionButton.isEnabled = true
        if TemporaryDataStorage.shared.difficultyLevel == "easy" {
            screen?.questionLabel.text = viewModel.getQuestions(index: currentIndex)
            screen?.firstOptionLabel.text = viewModel.getAnswer1(index: currentIndex)
            screen?.secondOptionLabel.text = viewModel.getAnswer2(index: currentIndex)
            screen?.thirdOptionLabel.text = viewModel.getAnswer3(index: currentIndex)
        }
        screen?.nextButton.isEnabled = false
        screen?.confirmButton.isEnabled = false
    }
}

extension QuestionsViewController: QuestionsViewProtocol {
    func answeredQuestionButton(option: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.screen?.firstOptionButton.backgroundColor = option == "first" ? .black : .customWhite
            self.screen?.secondOptionButton.backgroundColor = option == "second" ? .black : .customWhite
            self.screen?.thirdOptionButton.backgroundColor = option == "third" ? .black : .customWhite
            self.screen?.confirmButton.isEnabled = true
        }
    }
    func tappedFirstOptionButton() {
        answeredQuestionButton(option: "first")
        TemporaryDataStorage.shared.currentOption = screen?.firstOptionLabel.text ?? ""
    }
    func tappedSecondOptionButton() {
        answeredQuestionButton(option: "second")
        TemporaryDataStorage.shared.currentOption = screen?.secondOptionLabel.text ?? ""
    }
    func tappedThirdOptionButton() {
        answeredQuestionButton(option: "third")
        TemporaryDataStorage.shared.currentOption = screen?.thirdOptionLabel.text ?? ""
    }
    
    func tappedConfirmButton() {
        let result = viewModel.checkAnswer(index: currentIndex)
        changeToGreenOrRed(result)
        if result {
            TemporaryDataStorage.shared.currentPoints += 1
            screen?.pointsLabel.text = TemporaryDataStorage.shared.currentQuestion != 10 ? "0\(TemporaryDataStorage.shared.currentPoints)/10" : "\(TemporaryDataStorage.shared.currentPoints)/10"
        }
        screen?.confirmButton.isEnabled = false
        screen?.firstOptionButton.isEnabled = false
        screen?.secondOptionButton.isEnabled = false
        screen?.thirdOptionButton.isEnabled = false
        screen?.nextButton.isEnabled = true
        currentIndex = currentIndex < 10 ? currentIndex + 1 : currentIndex
        if currentIndex == 10 {
            // code to show final score
        }
    }
    func changeToGreenOrRed(_ result: Bool) {
        let optionLabelMap = [
            viewModel.easyquestions.option1[currentIndex]: screen?.firstOptionLabel,
            viewModel.easyquestions.option2[currentIndex]: screen?.secondOptionLabel,
            viewModel.easyquestions.option3[currentIndex]: screen?.thirdOptionLabel
        ]
        
        if result {
            optionLabelMap[viewModel.easyquestions.correct[currentIndex]]??.textColor = .systemGreen
        } else {
            let incorrectLabel = optionLabelMap[TemporaryDataStorage.shared.currentOption]
            incorrectLabel??.textColor = .systemRed
        }
    }
    func tappedNextButton() {
        print(TemporaryDataStorage.shared.currentQuestion)
        screen?.nextButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.screen?.firstOptionButton.backgroundColor = .customWhite
            self.screen?.secondOptionButton.backgroundColor = .customWhite
            self.screen?.thirdOptionButton.backgroundColor = .customWhite
            self.screen?.firstOptionLabel.textColor = .black
            self.screen?.secondOptionLabel.textColor = .black
            self.screen?.thirdOptionLabel.textColor = .black
        }
        if currentIndex == 9 {
            screen?.nextButton.setTitle("Finish game", for: .normal)
        }
        TemporaryDataStorage.shared.currentQuestion += 1
        loadQuestion()
    }
    func tappedStartNewGameButton() {
        navigationController?.popToRootViewController(animated: true)
    }
}
