//
//  RealmService.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 10/01/2024.
//

import UIKit
import RealmSwift

class RealmService {
	private var orderedPlayers: [PlayerRealm]?
	
	@MainActor
	public func saveRealmService() async {
		let app = RealmSwift.App(id: "ts-quiz2-akffn")
		do {
			let user = try await app.login(credentials: .anonymous)
			let config = user.flexibleSyncConfiguration()

			let realm = try await Realm(configuration: config, downloadBeforeOpen: .once)

			try realm.write {
				var player = PlayerRealm()
				if let name = UserDataModel.shared.newPlayer?.name,
				   let points = UserDataModel.shared.newPlayer?.points,
				   let difficulty = UserDataModel.shared.newPlayer?.difficulty,
				   let era = UserDataModel.shared.newPlayer?.era {
					player = PlayerRealm(name, era, difficulty, 0, points)
				}
			  realm.add(player)
			}
			UserDataModel.shared.deleteCurrentSessionData()
		} catch {
			print("An error occurred while saving to Realm database: \(error.localizedDescription)")
		}
	}
	
	@MainActor
	public func getRealmData() async -> Results<PlayerRealm>? {
		var rankedPlayers: Results<PlayerRealm>?
		let app = RealmSwift.App(id: "ts-quiz2-akffn")
		do {
			let user = try await app.login(credentials: .anonymous)
			let config = user.flexibleSyncConfiguration(initialSubscriptions: { subscriptions in
				subscriptions.append(QuerySubscription<PlayerRealm>(name: "players"))
			})
			
			let realm = try await Realm(configuration: config, downloadBeforeOpen: .once)
			
			orderedPlayers = realm.objects(PlayerRealm.self)
				.sorted(by: { if $0.points != $1.points { // pontuation is different
					return $0.points > $1.points
				} else { // pontuation is the same, check difficulty
					let difficulties = ["easy", "intermediate", "hard"]
					return difficulties.firstIndex(of: $0.difficulty)! < difficulties.firstIndex(of: $1.difficulty)!
				}
				})
			if let players = orderedPlayers {
				rankedPlayers = rankPlayers(players, realm)
			}
		} catch {
			print("An error occurred: \(error)")
		}
		return rankedPlayers?.sorted(byKeyPath: "rank", ascending: true) ?? nil
	}
	
	@MainActor
	private func rankPlayers(_ orderedPlayers: [PlayerRealm], _ realm: Realm) -> Results<PlayerRealm> {
		try! realm.write {
			var currentRank = 1
			var previousPlayer: PlayerRealm?
			
			for player in orderedPlayers {
				if let previous = previousPlayer {
					if previous.points == player.points && previous.difficulty == player.difficulty {
						player.rank = currentRank
					} else {
						currentRank += 1
						player.rank = currentRank
					}
				} else {
					player.rank = currentRank
				}
				previousPlayer = player
			}
		}
		return realm.objects(PlayerRealm.self)
	}
}
