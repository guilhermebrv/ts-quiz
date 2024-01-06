//
//  PlayerRealm.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 05/01/2024.
//

import Foundation
import RealmSwift

class PlayerRealm: Object, Identifiable {
	@Persisted(primaryKey: true) var _id: ObjectId
	@Persisted var name: String
	@Persisted var points: Int16
	@Persisted var rank: Int16
	@Persisted var era: String
	@Persisted var difficulty: String
	@Persisted var difficultyLevel: Int16
	
	convenience init(name: String, points: Int16, rank: Int16, era: String, difficulty: String, difficultyLevel: Int16) {
		self.init()
		self.name = name
		self.points = points
		self.rank = rank
		self.era = era
		self.difficulty = difficulty
		self.difficultyLevel = difficultyLevel
	}
}
