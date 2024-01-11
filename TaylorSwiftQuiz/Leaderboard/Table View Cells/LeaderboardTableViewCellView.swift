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
		view.backgroundColor = .customWhite
		view.layer.cornerRadius = 15
		view.clipsToBounds = true
		return view
	}()
	
	lazy var playerPhoto: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		image.layer.cornerRadius = 60 / 2
		image.clipsToBounds = true
		image.layer.borderColor = UIColor.black.cgColor
		image.layer.borderWidth = 2
		image.image = UIImage(named: "player-photo")
		return image
	}()
	
	lazy var playerStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.alignment = .leading
		stack.distribution = .fillEqually
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
	
	lazy var playerDifficultyLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .customWhite
		label.font = UIFont(name: "Suisse Int'l Mono", size: 10)
		return label
	}()
	
	lazy var playerScoreButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.customWhite, for: .normal)
		button.backgroundColor = .lightGray.withAlphaComponent(0.5)
		button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 24)
		button.clipsToBounds = true
		button.layer.cornerRadius = 60 / 2
		return button
	}()
	
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
		addSubview(bgView)
		addSubview(playerPhoto)
		addSubview(playerStackView)
		playerStackView.addArrangedSubview(playerNameLabel)
		playerStackView.addArrangedSubview(playerDifficultyLabel)
		playerStackView.addArrangedSubview(playerPositionLabel)
		addSubview(playerScoreButton)
	}
	
	private func configConstraints() {
		NSLayoutConstraint.activate([
			bgView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
			bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			
			playerPhoto.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
			playerPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerPhoto.widthAnchor.constraint(equalToConstant: 60),
			playerPhoto.heightAnchor.constraint(equalToConstant: 60),
			
			playerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerStackView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8),
			playerStackView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -10),
			playerStackView.leadingAnchor.constraint(equalTo: playerPhoto.trailingAnchor, constant: 15),
			playerStackView.trailingAnchor.constraint(equalTo: playerScoreButton.leadingAnchor, constant: -15),
			
			playerScoreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerScoreButton.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20),
			playerScoreButton.widthAnchor.constraint(equalToConstant: 60),
			playerScoreButton.heightAnchor.constraint(equalToConstant: 60)
		])
	}

}
