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
				guard let newPlayer = UserDataModel.shared.newPlayer,
					  let name = newPlayer.name,
				      let difficulty = newPlayer.difficulty,
					  let era = newPlayer.era,
				      let photo = newPlayer.photo
				else {
					print("Invalid or incomplete data for new player")
					return
				}
				let player = PlayerRealm(name, photo, era, difficulty, 0, newPlayer.points)
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
			
			let allPlayers = realm.objects(PlayerRealm.self)
			if allPlayers.count < 2 {
				return allPlayers
			}
			
			orderedPlayers = realm.objects(PlayerRealm.self).sorted(by: {
				if $0.points != $1.points { // pontuation is different
					return $0.points > $1.points
				} else { // pontuation is the same, check difficulty
					let difficulties = ["easy", "intermediate", "hard"]
					if let index0 = difficulties.firstIndex(of: $0.difficulty),
					   let index1 = difficulties.firstIndex(of: $1.difficulty) {
						return index0 > index1
					} else {
						return false
					}
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
					if previous.points != player.points || previous.difficulty != player.difficulty {
						currentRank += 1
					}
				}
				player.rank = currentRank
				previousPlayer = player
			}
		}
		return realm.objects(PlayerRealm.self)
	}
	
	static func deleteRealmFile() {
		let realmURL = Realm.Configuration.defaultConfiguration.fileURL!

		let realmURLs = [
			realmURL,
			realmURL.appendingPathExtension("lock"),
			realmURL.appendingPathExtension("note"),
			realmURL.appendingPathExtension("management")
		]

		let fileManager = FileManager.default
		for URL in realmURLs {
			do {
				if fileManager.fileExists(atPath: URL.path) {
					try fileManager.removeItem(at: URL)
				}
			} catch {
				print("Error deleting Realm file: \(error)")
			}
		}
	}

}
