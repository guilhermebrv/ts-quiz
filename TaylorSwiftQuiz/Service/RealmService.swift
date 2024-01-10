//
//  RealmService.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 10/01/2024.
//

import UIKit
import RealmSwift

class RealmService {
	private var players: Results<PlayerRealm>?
	
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
				   let era = UserDataModel.shared.newPlayer?.era {
					player = PlayerRealm(name, era, points)
				}
			  realm.add(player)
			}
			UserDataModel.shared.deleteCurrentSessionData()
		} catch {
			print("An error occurred while saving to Realm database: \(error.localizedDescription)")
		}
	}
	
	@MainActor
	public func getRealmData(tableToUpdate: UITableView) async -> Results<PlayerRealm>? {
		let app = RealmSwift.App(id: "ts-quiz2-akffn")
		do {
			let user = try await app.login(credentials: .anonymous)
			let config = user.flexibleSyncConfiguration(initialSubscriptions: { subscriptions in
				subscriptions.append(QuerySubscription<PlayerRealm>(name: "players"))
			})

			let realm = try await Realm(configuration: config, downloadBeforeOpen: .once)
			
			players = realm.objects(PlayerRealm.self)
			
			DispatchQueue.main.async {
				tableToUpdate.reloadData()
			}
		} catch {
			print("An error occurred: \(error)")
		}
		return players ?? nil
	}
}
