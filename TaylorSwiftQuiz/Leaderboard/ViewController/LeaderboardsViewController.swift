//
//  LeaderboardsViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit
import CoreData
import RealmSwift

class LeaderboardsViewController: UIViewController {
	private var screen: LeaderboardsView?
	private var viewModel: LeaderboardViewModel = LeaderboardViewModel()
	private var players: Results<PlayerRealm>?
	private var playersNumber: Int = 0
	
	@MainActor
	public func test() async {
		let app = RealmSwift.App(id: "ts-quiz2-akffn")
		do {
			let user = try await app.login(credentials: .anonymous)
			let config = user.flexibleSyncConfiguration(initialSubscriptions: { subscriptions in
				subscriptions.append(QuerySubscription<PlayerRealm>(name: "players"))
			})

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
			
			players = realm.objects(PlayerRealm.self)
			playersNumber = players?.count ?? 0
			
			DispatchQueue.main.async {
				self.screen?.playersScoresTableView.reloadData()
			}
			
			UserDataModel.shared.deleteCurrentSessionData()
		} catch {
			print("An error occurred: \(error)")
		}
	}

	override func loadView() {
		screen = LeaderboardsView()
		view = screen
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
		Task {
			await test()
		}
    }
}

extension LeaderboardsViewController {
	private func signProtocols() {
		screen?.delegate(delegate: self)
		screen?.playersScoresTableView.delegate = self
		screen?.playersScoresTableView.dataSource = self
	}
}

extension LeaderboardsViewController: LeaderboardsViewProtocol {
	func tappedStartNewGameButton() {
		navigationController?.popToRootViewController(animated: true)
	}
}

extension LeaderboardsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return playersNumber
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.identifier, for: indexPath) as? LeaderboardTableViewCell
		if let players = players {
			cell?.setupCell(player: players[indexPath.row])
		}
		return cell ?? UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return viewModel.heightForRowAt
	}
}
