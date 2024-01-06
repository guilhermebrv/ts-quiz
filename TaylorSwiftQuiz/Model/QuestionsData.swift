//
//  QuestionsData.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 06/01/2024.
//

import Foundation

// MARK: - QuestionsData
struct QuestionsData: Codable {
	var easy, intermediate, hard: [Difficulty]
	
	enum CodingKeys: String, CodingKey {
		case easy = "easy"
		case intermediate = "intermediate"
		case hard = "hard"
	}
}

// MARK: - Difficulty
struct Difficulty: Codable {
	var question: String?
	var options: [String]?
	var correct: String?
}
