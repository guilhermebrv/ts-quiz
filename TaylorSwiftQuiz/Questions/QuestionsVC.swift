//
//  QuestionsVC.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

class QuestionsVC: UIViewController {
    
    var easyquestions = Questions(questions: ["do you know this is the first easy question?", 
                                              "do you know this is the second easy question",
                                              "do you know this is the third easy question?",
                                              "do you know this is the fourth easy question",
                                              "do you know this is the fifth easy question?",
                                              "do you know this is the sixth easy question",
                                              "do you know this is the seventh easy question?",
                                              "do you know this is the eighty easy question",
                                              "do you know this is the ninety easy question?",
                                              "do you know this is the tenth easy question"],
                                  option1: ["1 - this is the first easy answer",
                                            "1 - this is the second easy answer",
                                            "1 - this is the third easy answer",
                                            "1 - this is the fourth easy answer",
                                            "1 - this is the fifth easy answer",
                                            "1 - this is the sixty easy answer",
                                            "1 - this is the seventh easy answer",
                                            "1 - this is the eighty easy answer",
                                            "1 - this is the ninety easy answer",
                                            "1 - this is the tenth easy answer"],
                                  option2: ["2 - this is the first easy answer",
                                            "2 - this is the second easy answer",
                                            "2 - this is the third easy answer",
                                            "2 - this is the fourth easy answer",
                                            "2 - this is the fifth easy answer",
                                            "2 - this is the sixty easy answer",
                                            "2 - this is the seventh easy answer",
                                            "2 - this is the eighty easy answer",
                                            "2 - this is the ninety easy answer",
                                            "2 - this is the tenth easy answer"],
                                  option3: ["3 - this is the first easy answer",
                                            "3 - this is the second easy answer",
                                            "3 - this is the third easy answer",
                                            "3 - this is the fourth easy answer",
                                            "3 - this is the fifth easy answer",
                                            "3 - this is the sixty easy answer",
                                            "3 - this is the seventh easy answer",
                                            "3 - this is the eighty easy answer",
                                            "3 - this is the ninety easy answer",
                                            "3 - this is the tenth easy answer"],
                                  correct: ["1 - this is the first easy answer",
                                            "2 - this is the second easy answer",
                                            "3 - this is the third easy answer",
                                            "2 - this is the fourth easy answer",
                                            "3 - this is the fifth easy answer",
                                            "1 - this is the sixty easy answer",
                                            "1 - this is the seventh easy answer",
                                            "3 - this is the eighty easy answer",
                                            "2 - this is the ninety easy answer",
                                            "1 - this is the tenth easy answer"])
    
    var currentIndex: Int = 0
    
    var QuestionView: QuestionsView?
    
    override func loadView() {
        QuestionView = QuestionsView()
        view = QuestionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionView?.delegate(delegate: self)
        loadFirstQuestion()
    }
    
    public func loadFirstQuestion() {
        if TemporaryDataStorage.shared.difficultyLevel == "easy" {
            QuestionView?.questionLabel.text = easyquestions.questions[currentIndex]
            QuestionView?.firstOptionLabel.text = easyquestions.option1[currentIndex]
            QuestionView?.secondOptionLabel.text = easyquestions.option2[currentIndex]
            QuestionView?.thirdOptionLabel.text = easyquestions.option3[currentIndex]
        }
        QuestionView?.nextButton.isEnabled = false
        QuestionView?.confirmButton.isEnabled = false
    }
}

extension QuestionsVC: QuestionsViewProtocol {
    
    func tappedFirstOptionButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.QuestionView?.firstOptionButton.backgroundColor = .black
            self.QuestionView?.secondOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.QuestionView?.thirdOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        }
        TemporaryDataStorage.shared.currentOption = QuestionView?.firstOptionLabel.text ?? ""
        QuestionView?.confirmButton.isEnabled = true
    }
    
    func tappedSecondOptionButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.QuestionView?.firstOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.QuestionView?.secondOptionButton.backgroundColor = .black
            self.QuestionView?.thirdOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        }
        TemporaryDataStorage.shared.currentOption = QuestionView?.secondOptionLabel.text ?? ""
        QuestionView?.confirmButton.isEnabled = true
    }
    
    func tappedThirdOptionButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.QuestionView?.firstOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.QuestionView?.secondOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.QuestionView?.thirdOptionButton.backgroundColor = .black
        }
        TemporaryDataStorage.shared.currentOption = QuestionView?.thirdOptionLabel.text ?? ""
        QuestionView?.confirmButton.isEnabled = true
    }
    
    func tappedConfirmButton() {
        changeToGreenOrRed()
        QuestionView?.confirmButton.isEnabled = false
        QuestionView?.firstOptionButton.isEnabled = false
        QuestionView?.secondOptionButton.isEnabled = false
        QuestionView?.thirdOptionButton.isEnabled = false
        QuestionView?.nextButton.isEnabled = true
    }
    
    func changeToGreenOrRed() {
        if TemporaryDataStorage.shared.currentOption == easyquestions.correct[currentIndex] {
            if easyquestions.option1[currentIndex] == easyquestions.correct[currentIndex] {
                QuestionView?.firstOptionLabel.textColor = .systemGreen
            } else if easyquestions.option2[currentIndex] == easyquestions.correct[currentIndex] {
                QuestionView?.secondOptionLabel.textColor = .systemGreen
            } else {
                QuestionView?.thirdOptionLabel.textColor = .systemGreen
            }
            TemporaryDataStorage.shared.currentPoints += 1
            if TemporaryDataStorage.shared.currentQuestion != 10 {
                QuestionView?.pointsLabel.text = "0\(TemporaryDataStorage.shared.currentPoints)/10"
            } else {
                QuestionView?.pointsLabel.text = "\(TemporaryDataStorage.shared.currentPoints)/10"
            }
        } else {
            if easyquestions.option1[currentIndex] == easyquestions.correct[currentIndex] {
                QuestionView?.firstOptionLabel.textColor = .systemGreen
            } else if easyquestions.option2[currentIndex] == easyquestions.correct[currentIndex] {
                QuestionView?.secondOptionLabel.textColor = .systemGreen
            } else if easyquestions.option3[currentIndex] == easyquestions.correct[currentIndex] {
                QuestionView?.thirdOptionLabel.textColor = .systemGreen
            }
            
            if TemporaryDataStorage.shared.currentOption == easyquestions.option1[currentIndex] {
                QuestionView?.firstOptionLabel.textColor = .systemRed
            } else if TemporaryDataStorage.shared.currentOption == easyquestions.option2[currentIndex] {
                QuestionView?.secondOptionLabel.textColor = .systemRed
            } else {
                QuestionView?.thirdOptionLabel.textColor = .systemRed
            }
        }
    }
    
    func tappedNextButton() {
        QuestionView?.nextButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.QuestionView?.firstOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.QuestionView?.secondOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
            self.QuestionView?.thirdOptionButton.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        }
        if currentIndex < 10 {
            currentIndex += 1
        }
        QuestionView?.firstOptionLabel.textColor = .black
        QuestionView?.secondOptionLabel.textColor = .black
        QuestionView?.thirdOptionLabel.textColor = .black
        if currentIndex == 9 {
            QuestionView?.nextButton.setTitle("Finish game", for: .normal)
        }
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        QuestionView?.firstOptionButton.isEnabled = true
        QuestionView?.secondOptionButton.isEnabled = true
        QuestionView?.thirdOptionButton.isEnabled = true
        if TemporaryDataStorage.shared.difficultyLevel == "easy" {
            QuestionView?.questionLabel.text = easyquestions.questions[currentIndex]
            QuestionView?.firstOptionLabel.text = easyquestions.option1[currentIndex]
            QuestionView?.secondOptionLabel.text = easyquestions.option2[currentIndex]
            QuestionView?.thirdOptionLabel.text = easyquestions.option3[currentIndex]
        }
        TemporaryDataStorage.shared.currentQuestion += 1
        QuestionView?.questionNumberLabel.text = "Question \(TemporaryDataStorage.shared.currentQuestion)"
    }
}
