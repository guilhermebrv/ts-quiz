//
//  RealmService.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 10/01/2024.
//

import UIKit
import RealmSwift

class RealmService {
	private var players: [PlayerRealm]?
	
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
					player = PlayerRealm(name, era, difficulty, points)
				}
			  realm.add(player)
			}
			UserDataModel.shared.deleteCurrentSessionData()
		} catch {
			print("An error occurred while saving to Realm database: \(error.localizedDescription)")
		}
	}
	
	@MainActor
	public func getRealmData() async -> [PlayerRealm]? {
		let app = RealmSwift.App(id: "ts-quiz2-akffn")
		do {
			let user = try await app.login(credentials: .anonymous)
			let config = user.flexibleSyncConfiguration(initialSubscriptions: { subscriptions in
				subscriptions.append(QuerySubscription<PlayerRealm>(name: "players"))
			})

			let realm = try await Realm(configuration: config, downloadBeforeOpen: .once)
			
			players = realm.objects(PlayerRealm.self)
				.sorted(by: { if $0.points != $1.points { // pontuation is different
								return $0.points > $1.points
							} else { // pontuation is the same, check difficulty
								let difficulties = ["easy", "intermediate", "hard"]
								return difficulties.firstIndex(of: $0.difficulty)! < difficulties.firstIndex(of: $1.difficulty)!
							}
						})
		} catch {
			print("An error occurred: \(error)")
		}
		return players ?? nil
	}
	
	public func rankPlayers() {
		let realm = try! Realm()
		let allPlayers = realm.objects(PlayerRealm.self)
							 .sorted(byKeyPath: "score", ascending: false)
							 .sorted(by: { if $0.difficulty == $1.difficulty {
											return false
										}
										 if $0.difficulty == "hard" {
											 return true
										 }
										 if $0.difficulty == "intermediate" && $1.difficulty == "easy" {
											 return true
										 }
										 return false
							 })
//		try! realm.write {
//			var currentRank = 1
//			var previousPlayer: PlayerRealm?
//			
//			for player in allPlayers {
//				if let previous = previousPlayer {
//					// Mesma pontuação e dificuldade = mesmo rank
//					if previous.points == player.points && previous.difficulty == player.difficulty {
//						player.rank = currentRank
//					} else {
//						currentRank += 1
//						player.rank = currentRank
//					}
//				} else {
//					player.rank = currentRank
//				}
//				previousPlayer = player
//			}
//		}
	}
}
