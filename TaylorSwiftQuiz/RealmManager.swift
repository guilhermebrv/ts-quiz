//
//  Realm.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 05/01/2024.
//

import UIKit
import RealmSwift

class RealmManager {
	let app = App(id: "application-ts-quiz-ylvxc")
	var realm = try! Realm()
	@Published var user: User?
	@Published var configuration: Realm.Configuration?
	@Published var player: Results<PlayerRealm>?
	
	@objc private func startRealm() async {
		user = try? await app.login(credentials: Credentials.anonymous)
		
		self.configuration = user?.flexibleSyncConfiguration(initialSubscriptions: { SyncSubscriptionSet in
			if let _ = SyncSubscriptionSet.first(named: "all-players") {
				return
			} else {
				SyncSubscriptionSet.append(QuerySubscription<PlayerRealm>(name: "all-players"))
			}
				return
		}, rerunOnOpen: true)
		
		realm = try! await Realm(configuration: configuration!, downloadBeforeOpen: .always)
		player = realm.objects(PlayerRealm.self)
						.sorted(byKeyPath: "points", ascending: false)
						.sorted(byKeyPath: "difficultylevel", ascending: false)
	}
}
