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
	private var realmService = RealmService()
	private var players: Results<PlayerRealm>?
	
	override func loadView() {
		screen = LeaderboardsView()
		view = screen
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		screen?.spinner.startAnimating()
		signProtocols()
		Task {
			players = await viewModel.getDataFromRealm()
			screen?.playersScoresTableView.reloadData()
			screen?.spinner.stopAnimating()
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
		return players?.count ?? 0
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
