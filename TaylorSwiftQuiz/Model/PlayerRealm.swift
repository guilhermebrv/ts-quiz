//
//  PlayerRealm.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 09/01/2024.
//

import RealmSwift

class PlayerRealm: Object {
	@Persisted(primaryKey: true) public var _id: ObjectId = ObjectId.generate()
	@Persisted public var era: String
	@Persisted public var name: String
	@Persisted public var points: Int32
	
	convenience init(_ name: String, _ era: String, _ points: Int32) {
		self.init()
		self.name = name
		self.era = era
		self.points = points
	}
}
