//
//  LeaderboardViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit

class LeaderboardViewModel {
	
	public var numberOfRowsInSection: Int {
		let players = UserDataModel.shared.countPlayers()
		return players
	}
	
	public var heightForRowAt: CGFloat {
		return 80
	}
}
