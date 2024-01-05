//
//  LeaderboardViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit

class LeaderboardViewModel {
	private var realmManager = RealmManager()
	
	//delete this:
	public var getPlayersData: [Player] {
		let players = UserDataModel.shared.fetchPlayers()
		return players
	}
	
	public var numberOfRowsInSection: Int {
		let playerNumber = realmManager.player
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
