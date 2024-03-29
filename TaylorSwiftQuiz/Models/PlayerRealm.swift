//
//  PlayerRealm.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 09/01/2024.
//

import RealmSwift
import UIKit

class PlayerRealm: Object {
	@Persisted(primaryKey: true) public var _id: ObjectId = ObjectId.generate()
	@Persisted public var era: String
	@Persisted public var name: String
	@Persisted public var photo: String
	@Persisted public var difficulty: String
	@Persisted public var rank: Int
	@Persisted public var points: Int32
	
	convenience init(_ name: String, _ photo: String, _ era: String, _ difficulty: String, _ rank: Int, _ points: Int32) {
		self.init()
		self.name = name
		self.photo = photo
		self.difficulty = difficulty
		self.era = era
		self.rank = rank
		self.points = points
	}
}
