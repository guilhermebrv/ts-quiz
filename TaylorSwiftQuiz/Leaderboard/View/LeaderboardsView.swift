//
//  LeaderboardsView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit

protocol LeaderboardsViewProtocol: AnyObject {
	func tappedStartNewGameButton()
}

class LeaderboardsView: UIView {
	private weak var delegate: LeaderboardsViewProtocol?
	public func delegate(delegate: LeaderboardsViewProtocol?) {
		self.delegate = delegate
	}
	
	lazy var leaderboardLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .black
		label.text = "Leaderboard"
		label.font = UIFont(name: "Suisse Int'l Mono", size: 30)
		return label
	}()
	
	lazy var playersScoresTableView: UITableView = {
		let tableview = UITableView()
		tableview.translatesAutoresizingMaskIntoConstraints = false
		tableview.allowsSelection = false
		tableview.backgroundColor = .customWhite
		tableview.showsVerticalScrollIndicator = false
		tableview.separatorStyle = .none
		tableview.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.identifier)
		return tableview
	}()
	
	lazy var startNewGameButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Start new game", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 22)
		button.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
		button.layer.borderWidth = 2
		button.layer.borderColor = UIColor.black.cgColor
		button.addTarget(self, action: #selector(tappedStartNewGameButton), for: .touchUpInside)
		button.backgroundColor = .white
		return button
	}()
	
	@objc public func tappedStartNewGameButton() {
		delegate?.tappedStartNewGameButton()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addElements()
		configConstraints()
		backgroundColor = .customWhite
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addElements() {
		addSubview(leaderboardLabel)
		addSubview(playersScoresTableView)
		addSubview(startNewGameButton)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			leaderboardLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
			leaderboardLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
			
			playersScoresTableView.topAnchor.constraint(equalTo: leaderboardLabel.bottomAnchor, constant: 15),
			playersScoresTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			playersScoresTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			playersScoresTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -120),
			
			startNewGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			startNewGameButton.topAnchor.constraint(equalTo: playersScoresTableView.bottomAnchor, constant: 20),
			startNewGameButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			startNewGameButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
			startNewGameButton.heightAnchor.constraint(equalToConstant: 60),
		])
	}
}
