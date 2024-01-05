//
//  QuestionsViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 28/12/2023.
//

import UIKit

class QuestionsViewModel {
    public var easyquestions = Questions(questions: ["do you know this is the first easy question?",
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

    // MARK: SAVE USER DATA
    public func saveUserOption(_ option: String) {
        UserDataModel.shared.saveOption(option)
    }
    
    public func saveUserPoint() {
        UserDataModel.shared.newPlayer?.points += 1
    }
    
    public func saveNextQuestion() {
        UserDataModel.shared.newPlayer?.currentQuestion += 1
    }
	
	// MARK: CONVERTING TO JSON TO SAVE IN DATABASE
	private func convertToDictionary() -> [String: Any] {
		var playerDict = [String: Any]()
		playerDict["name"] = UserDataModel.shared.newPlayer?.name
		//playerDict["id"] = UserDataModel.shared.newPlayer?.id
		playerDict["points"] = UserDataModel.shared.newPlayer?.points
		playerDict["era"] = UserDataModel.shared.newPlayer?.era
		playerDict["difficulty"] = UserDataModel.shared.newPlayer?.difficulty
		print(playerDict)
		return playerDict
	}
	
	private func convertToJSON(player: Player) -> Data? {
		let playerDict = convertToDictionary()
		do {
			let jsonData = try JSONSerialization.data(withJSONObject: playerDict, options: [])
			return jsonData
		} catch let error as NSError {
			print("Error converting to JSON: \(error.localizedDescription)")
			return nil
		}
	}
	
	public func convertDataToJSON() {
		if let jsonData = convertToJSON(player: UserDataModel.shared.newPlayer ?? Player()) {
			//
		}
	}

    
    // MARK: CHECK FOR USER ANSWER
    public func checkAnswer(index: Int) -> Bool {
        if UserDataModel.shared.newPlayer?.selectedOption == easyquestions.correct[index] {
            return true
        } else {
            return false
        }
    }
    
    public func getSelectedOption() -> String {
        return UserDataModel.shared.newPlayer?.selectedOption ?? ""
    }
    
    // MARK: DATA TO LOAD SCREEN
    public func getQuestions(index: Int) -> String {
        return easyquestions.questions[index]
    }
    
    public func getAnswer1(index: Int) -> String {
        return easyquestions.option1[index]
    }
    
    public func getAnswer2(index: Int) -> String {
        return easyquestions.option2[index]
    }
    
    public func getAnswer3(index: Int) -> String {
        return easyquestions.option3[index]
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
