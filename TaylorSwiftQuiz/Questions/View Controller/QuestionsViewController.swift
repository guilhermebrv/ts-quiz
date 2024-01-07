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
	var questions: [Difficulty]?
    
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
    private func loadQuestion() {
        let number = viewModel.getQuestionNumber()
		questions = viewModel.getQuestions(difficulty: viewModel.getDifficultyLevel())
        screen?.questionNumberLabel.text = "Question \(number)"
        screen?.firstOptionButton.isEnabled = true
        screen?.secondOptionButton.isEnabled = true
        screen?.thirdOptionButton.isEnabled = true
		screen?.questionLabel.text = questions?[currentIndex].question
		screen?.firstOptionLabel.text = questions?[currentIndex].options?[0]
		screen?.secondOptionLabel.text = questions?[currentIndex].options?[1]
		screen?.thirdOptionLabel.text = questions?[currentIndex].options?[2]
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
		let result = viewModel.checkAnswer(index: currentIndex, questions: questions ?? [Difficulty]())
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
    }
    func changeToGreenOrRed(_ result: Bool) {
		let optionLabelMap = [viewModel.playerCurrentQuestions?[self.currentIndex].options?[0]: screen?.firstOptionLabel,
							  viewModel.playerCurrentQuestions?[self.currentIndex].options?[1]: screen?.secondOptionLabel,
							  viewModel.playerCurrentQuestions?[self.currentIndex].options?[2]: screen?.thirdOptionLabel]
        if result {
			optionLabelMap[viewModel.playerCurrentQuestions?[self.currentIndex].correct]??.textColor = .systemGreen
        } else {
			optionLabelMap[viewModel.playerCurrentQuestions?[self.currentIndex].correct]??.textColor = .systemGreen
            let incorrectLabel = optionLabelMap[viewModel.getSelectedOption()]
            incorrectLabel??.textColor = .systemRed
        }
    }
    func tappedNextButton() {
        if currentIndex > 9 {
            let score = TotalScoreViewController()
            navigationController?.pushViewController(score, animated: true)
			viewModel.savePlayerToRealm()
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
