//
//  QuestionsViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

class QuestionsViewController: UIViewController {
    private var screen: QuestionsView?
    private var viewModel: QuestionsViewModel = QuestionsViewModel()
	var currentIndex: Int = 0
	var questions: [Difficulty]?
    
    override func loadView() {
        screen = QuestionsView()
        view = screen
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		hideItemsWhileLoading()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
		var isDataLoaded = false
		let number = viewModel.getQuestionNumber()
		screen?.questionNumberLabel.text = "Question \(number)"
		
		if !isDataLoaded {
			viewModel.fetchRequest { data in
				DispatchQueue.main.async {
					if data {
						isDataLoaded = true
						self.updateQuestions()
						self.finishedLoading()
					} else {
						print("error fetching data from API")
					}
				}
			}
		} else {
			updateQuestions()
		}
		screen?.firstOptionButton.isEnabled = true
		screen?.secondOptionButton.isEnabled = true
		screen?.thirdOptionButton.isEnabled = true
        screen?.nextButton.isEnabled = false
        screen?.confirmButton.isEnabled = false
    }
	private func hideItemsWhileLoading() {
		screen?.spinner.startAnimating()
		screen?.questionNumberLabel.isHidden = true
		screen?.startNewGameButton.isHidden = true
		screen?.nextButton.isHidden = true
		screen?.confirmButton.isHidden = true
		screen?.firstOptionButton.isHidden = true
		screen?.secondOptionButton.isHidden = true
		screen?.thirdOptionButton.isHidden = true
	}
	private func finishedLoading() {
		screen?.spinner.stopAnimating()
		screen?.questionNumberLabel.isHidden = false
		screen?.startNewGameButton.isHidden = false
		screen?.nextButton.isHidden = false
		screen?.confirmButton.isHidden = false
		screen?.firstOptionButton.isHidden = false
		screen?.secondOptionButton.isHidden = false
		screen?.thirdOptionButton.isHidden = false
	}
	private func updateQuestions() {
		if self.currentIndex == 0 {
			questions = viewModel.questionsData
			questions = questions?.shuffled()
		}
		screen?.questionLabel.text = questions?[self.currentIndex].question
		screen?.firstOptionLabel.text = questions?[self.currentIndex].options?[0]
		screen?.secondOptionLabel.text = questions?[self.currentIndex].options?[1]
		screen?.thirdOptionLabel.text = questions?[self.currentIndex].options?[2]
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
		let optionLabelMap = [questions?[self.currentIndex].options?[0]: screen?.firstOptionLabel,
							  questions?[self.currentIndex].options?[1]: screen?.secondOptionLabel,
							  questions?[self.currentIndex].options?[2]: screen?.thirdOptionLabel]
        if result {
			optionLabelMap[questions?[self.currentIndex].correct]??.textColor = .systemGreen
        } else {
			optionLabelMap[questions?[self.currentIndex].correct]??.textColor = .systemGreen
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
		AlertStartNewGame(controller: self).showAlert(title: "Warning", message: "Are you sure you want to start a new game and lose current progress?") {
			UserDataModel.shared.deleteCurrentSessionData()
			self.navigationController?.popToRootViewController(animated: true)
		}
    }
}
