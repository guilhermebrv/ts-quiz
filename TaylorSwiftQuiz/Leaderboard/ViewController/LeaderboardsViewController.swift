//
//  LeaderboardsViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit

class LeaderboardsViewController: UIViewController {
	private var screen: LeaderboardsView?
	private var viewModel: LeaderboardViewModel = LeaderboardViewModel()

	override func loadView() {
		screen = LeaderboardsView()
		view = screen
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
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
		return viewModel.numberOfRowsInSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return viewModel.heightForRowAt
	}
}
