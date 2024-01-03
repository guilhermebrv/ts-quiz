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
	}
}

extension LeaderboardsViewController: LeaderboardsViewProtocol {
	func tappedStartNewGameButton() {
		//
	}
}
