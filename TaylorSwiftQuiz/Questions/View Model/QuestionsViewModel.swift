//
//  QuestionsViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 28/12/2023.
//

import UIKit
import RealmSwift

class QuestionsViewModel {
	private var service: QuestionsService = QuestionsService()
	static var questionsData: QuestionsData?
	//private var questionsData: QuestionsData?
	public var playerCurrentQuestions: [Difficulty]?

	// MARK: FETCH QUESTIONS DATA FROM API
	public func fetchRequest() {
		service.fetchQuestionsData { result, error in
			if error == nil {
				QuestionsViewModel.questionsData = result
			} else {
				print("error fetching data to receive questions - \(String(describing: error?.localizedDescription))")
			}
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
	
	// MARK: SAVING FROM COREDATA TO REALM
	public func savePlayerToRealm() {
		let player = PlayerRealm(name: getPlayerName(), points: getCurrentPoints(), rank: 0, era: getEraData(), difficulty: getDifficultyLevel(), difficultyLevel: UserDataModel.shared.newPlayer?.difficultyLevel ?? 1)
		do {
			let realm = try Realm()
			try realm.write {
				realm.add(player)
			}
		} catch {
			print("error saving player data to Realm - \(error.localizedDescription)")
		}
	}
    
    // MARK: CHECK FOR USER ANSWER
	public func checkAnswer(index: Int, questions: [Difficulty]) -> Bool {
		let correctOption = questions[index].correct
		return UserDataModel.shared.newPlayer?.selectedOption == correctOption
    }
    
    public func getSelectedOption() -> String {
        return UserDataModel.shared.newPlayer?.selectedOption ?? ""
    }
	
	// MARK: METHOD TO SHUFFLE QUESTIONS
	private func shuffleQuestions(_ difficulty: String) -> [Difficulty] {
		var questions: [Difficulty]
		switch difficulty {
			case "easy":
			questions = QuestionsViewModel.questionsData?.easy ?? [Difficulty]()
			case "intermediate":
			questions = QuestionsViewModel.questionsData?.intermediate ?? [Difficulty]()
			case "hard":
			questions = QuestionsViewModel.questionsData?.hard ?? [Difficulty]()
			default:
				return [Difficulty]()
			}
		playerCurrentQuestions = questions.shuffled()
		return playerCurrentQuestions ?? [Difficulty]()
	}
    
    // MARK: DATA TO LOAD SCREEN
	public func getQuestions(difficulty: String) -> [Difficulty] {
		return shuffleQuestions(difficulty)
    }

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
