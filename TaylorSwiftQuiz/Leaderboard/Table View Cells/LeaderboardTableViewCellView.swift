//
//  LeaderboardTableViewCellView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit

class LeaderboardTableViewCellView: UIView {
	lazy var bgView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .bgGreen
		view.layer.cornerRadius = 15
		view.clipsToBounds = true
		return view
	}()
	
	lazy var playerPhoto: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		image.layer.cornerRadius = 30 / 2
		image.clipsToBounds = true
		image.layer.borderColor = UIColor.black.cgColor
		image.layer.borderWidth = 2
		image.image = UIImage(named: "player-photo")
		image.backgroundColor = .customWhite
		return image
	}()
	
	lazy var playerStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .leading
		stack.distribution = .fill
		stack.spacing = 10
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	lazy var playerNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .customWhite
		label.text = "Test Name"
		label.font = UIFont(name: "Suisse Int'l Mono", size: 15)
		return label
	}()
	
	lazy var playerPositionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .customWhite
		label.text = "#1"
		label.font = UIFont(name: "Suisse Int'l Mono", size: 12)
		return label
	}()
	
	lazy var difficultyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .customWhite
		label.text = "easy"
		label.font = UIFont(name: "Suisse Int'l Mono", size: 12)
		return label
	}()
	
	lazy var playerScoreLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .customWhite
		label.backgroundColor = .lightGray
		label.clipsToBounds = true
		label.layer.cornerRadius = 30 / 2
		label.text = "10"
		label.font = UIFont(name: "Suisse Int'l Mono", size: 16)
		return label
	}()
	
	private func addElements() {
		addSubview(bgView)
		addSubview(playerPhoto)
		addSubview(playerStackView)
		playerStackView.addArrangedSubview(playerNameLabel)
		playerStackView.addArrangedSubview(playerPositionLabel)
		addSubview(difficultyLabel)
		addSubview(playerScoreLabel)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			bgView.topAnchor.constraint(equalTo: topAnchor),
			bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
			bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
			bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			playerPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			playerPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerPhoto.widthAnchor.constraint(equalToConstant: 30),
			playerPhoto.heightAnchor.constraint(equalToConstant: 30),
			
			playerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerStackView.leadingAnchor.constraint(equalTo: playerPhoto.trailingAnchor, constant: 15),
			playerStackView.trailingAnchor.constraint(equalTo: difficultyLabel.leadingAnchor, constant: -15),
			
			difficultyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			difficultyLabel.trailingAnchor.constraint(equalTo: playerScoreLabel.leadingAnchor, constant: -15),
			
			playerScoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerScoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
		])
	}

}
