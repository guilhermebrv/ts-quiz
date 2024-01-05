//
//  LeaderboardViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit
import RealmSwift

class LeaderboardViewModel {
	
	public func fetchDataFromManager() {
		RealmManager.shared.fetchData()
	}
	
	public var getPlayersData: Results<PlayerRealm> {
		//let players = UserDataModel.shared.fetchPlayers()
		let players = RealmManager.shared.player!
		return players
	}
	
	public var numberOfRowsInSection: Int {
		let playerNumber = RealmManager.shared.player
		if let players = playerNumber {
			return players.count
		} else {
			return 0
		}
	}
	
	public var heightForRowAt: CGFloat {
		return 100
	}
}
