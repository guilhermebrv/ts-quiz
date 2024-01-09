//
//  QuestionsViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 28/12/2023.
//

import UIKit

class QuestionsViewModel {
	private var service: QuestionsService = QuestionsService()
	public var questionsData: [Difficulty]?

	// MARK: FETCH QUESTIONS DATA FROM API
	public func fetchRequest(completion: @escaping (Bool) -> Void) {
		service.fetchQuestionsData { [weak self] result, error in
			guard let data = result, error == nil else {
				completion(false)
				return
			}
			switch self?.getDifficultyLevel() {
			case "easy":
				self?.questionsData = data.easy
			case "intermediate":
				self?.questionsData = data.intermediate
			case "hard":
				self?.questionsData = data.hard
			default:
				completion(true)
			}
			completion(true)
		}
	}
	
    // MARK: SAVE USER DATA TO COREDATA
    public func saveUserOption(_ option: String) {
        UserDataModel.shared.saveOption(option)
    }
    
    public func saveUserPoint() {
        UserDataModel.shared.newPlayer?.points += 1
    }
    
    public func saveNextQuestion() {
        UserDataModel.shared.newPlayer?.currentQuestion += 1
    }
    
    // MARK: CHECK FOR USER ANSWER
	public func checkAnswer(index: Int, questions: [Difficulty]) -> Bool {
		let correctOption = questions[index].correct
		return UserDataModel.shared.newPlayer?.selectedOption == correctOption
    }
    
    public func getSelectedOption() -> String {
        return UserDataModel.shared.newPlayer?.selectedOption ?? ""
    }
    
    // MARK: DATA TO LOAD SCREEN
    public func getEraData() -> String {
        return UserDataModel.shared.newPlayer?.era ?? ""
    }
    
    public func getPlayerName() -> String {
        return UserDataModel.shared.newPlayer?.name ?? ""
    }
    
    public func getQuestionNumber() -> Int16 {
        return UserDataModel.shared.newPlayer?.currentQuestion ?? 0
    }
    
    public func getCurrentPoints() -> Int16 {
        return UserDataModel.shared.newPlayer?.points ?? 0
    }
    
    public func getDifficultyLevel() -> String {
        return UserDataModel.shared.newPlayer?.difficulty ?? ""
    }
}
