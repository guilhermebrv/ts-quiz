//
//  LeaderboardViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit
import RealmSwift

class LeaderboardViewModel {
	private let realmService = RealmService()
	
	public func getDataFromRealm() async -> Results<PlayerRealm>? {
		let players = await realmService.getRealmData() ?? nil
		return players
	}
	
	public var heightForRowAt: CGFloat {
		return 100
	}
}
