//
//  LeaderboardViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit

class LeaderboardViewModel {
	public var getPlayersData: [Player] {
		let players = UserDataModel.shared.fetchPlayers()
		return players
	}
	
	public var numberOfRowsInSection: Int {
		return UserDataModel.shared.countPlayers()
	}
	
	public var heightForRowAt: CGFloat {
		return 100
	}
}
