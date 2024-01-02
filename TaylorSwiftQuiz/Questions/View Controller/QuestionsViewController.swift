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
        setPlayerName()
        setEraColor()
        loadQuestion()
    }
}

extension QuestionsViewController {
    private func signProtocols() {
        screen?.delegate(delegate: self)
    }
    private func setEraColor() {
        let eraColorMap: [String: UIColor] = [
                "taylor-swift": .taylorswift,
                "fearless": .fearless,
                "speak-now": .speaknow,
                "red": .tsred,
                "1989": .ts1989,
                "reputation": .reputation,
                "lover": .lover,
                "folklore": .folklore,
                "evermore": .evermore,
                "midnights": .midnights]
        screen?.bgView.backgroundColor = eraColorMap[viewModel.getEraData()]
    }
    private func setPlayerName() {
        let name = viewModel.getPlayerName()
        screen?.playerName.text = name
    }
    private func setQuestionNumber() {
        let number = viewModel.getQuestionNumber()
        screen?.questionNumberLabel.text = "Question \(number)"
    }
    
    private func setCurrentPoints() {
        let points = viewModel.getCurrentPoints()
        screen?.pointsLabel.text = "\(points)/10"
    }
    private func loadQuestion() {
        let number = viewModel.getQuestionNumber()
        screen?.questionNumberLabel.text = "Question \(number)"
        screen?.firstOptionButton.isEnabled = true
        screen?.secondOptionButton.isEnabled = true
        screen?.thirdOptionButton.isEnabled = true
        if viewModel.getDifficultyLevel() == "easy" {
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
        if let option = screen?.firstOptionLabel.text {
            viewModel.saveUserOption(option)
        }
    }
    func tappedSecondOptionButton() {
        answeredQuestionButton(option: "second")
        if let option = screen?.secondOptionLabel.text {
            viewModel.saveUserOption(option)
        }
    }
    func tappedThirdOptionButton() {
        answeredQuestionButton(option: "third")
        if let option = screen?.thirdOptionLabel.text {
            viewModel.saveUserOption(option)
        }
    }
    
    func tappedConfirmButton() {
        let result = viewModel.checkAnswer(index: currentIndex)
        changeToGreenOrRed(result)
        if result {
            viewModel.saveUserPoint()
            screen?.pointsLabel.text = viewModel.getQuestionNumber() != 10 ? "0\(viewModel.getCurrentPoints())/10" : "\(viewModel.getCurrentPoints())/10"
        }
        screen?.confirmButton.isEnabled = false
        screen?.nextButton.isEnabled = true
        [self.screen?.firstOptionButton, self.screen?.secondOptionButton, self.screen?.thirdOptionButton].forEach { button in
            button?.isEnabled = false
        }
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
            let incorrectLabel = optionLabelMap[viewModel.getSelectedOption()]
            incorrectLabel??.textColor = .systemRed
        }
    }
    func tappedNextButton() {
        if currentIndex > 9 {
            let score = TotalScoreViewController()
            navigationController?.pushViewController(score, animated: true)
            return
        }
        screen?.nextButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            [self.screen?.firstOptionButton, self.screen?.secondOptionButton, self.screen?.thirdOptionButton].forEach { button in
                button?.backgroundColor = .customWhite
            }
            [self.screen?.firstOptionLabel, self.screen?.secondOptionLabel, self.screen?.thirdOptionLabel].forEach { label in
                label?.textColor = .customWhite
            }
        }
        if currentIndex == 9 {
            screen?.nextButton.setTitle("Finish game", for: .normal)
        }
        viewModel.saveNextQuestion()
        loadQuestion()
    }
    func tappedStartNewGameButton() {
        navigationController?.popToRootViewController(animated: true)
    }
}
