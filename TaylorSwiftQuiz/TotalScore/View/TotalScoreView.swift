//
//  TotalScoreView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 02/01/2024.
//

import UIKit

protocol TotalScoreViewProtocol: AnyObject {
    func tappedLeaderboardButton()
    func tappedStartNewGameButton()
}

class TotalScoreView: UIView {
    private weak var delegate: TotalScoreViewProtocol?
    public func delegate(delegate: TotalScoreViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bgGreen
        return view
    }()
    
    lazy var playerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        image.backgroundColor = .customWhite
        return image
    }()
    
    lazy var playerName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.text = "Test Name"
        label.font = UIFont(name: "Suisse Int'l Mono", size: 30)
        return label
    }()
    
    lazy var scoreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var playerScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.text = "8"
        label.textAlignment = .center
        label.font = UIFont(name: "Suisse Int'l Mono", size: 180)
        return label
    }()
    
    lazy var totalScoredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.text = "/10"
        label.textAlignment = .center
        label.font = UIFont(name: "Suisse Int'l Mono", size: 30)
        return label
    }()
    
    lazy var leaderboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Check Leaderboard", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 22)
        button.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(tappedLeaderboardButton), for: .touchUpInside)
        button.backgroundColor = .customWhite
        return button
    }()
    
    @objc public func tappedLeaderboardButton() {
        delegate?.tappedLeaderboardButton()
    }
    
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
        button.backgroundColor = .customWhite
        return button
    }()
    
    @objc public func tappedStartNewGameButton() {
        delegate?.tappedStartNewGameButton()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
        backgroundColor = .bgGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(bgView)
        playerStackView.addArrangedSubview(playerPhoto)
        playerStackView.addArrangedSubview(playerName)
        addSubview(playerStackView)
        scoreStackView.addArrangedSubview(playerScoreLabel)
        scoreStackView.addArrangedSubview(totalScoredLabel)
        addSubview(scoreStackView)
        addSubview(leaderboardButton)
        addSubview(startNewGameButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            playerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
                    
            playerPhoto.widthAnchor.constraint(equalToConstant: 60),
            playerPhoto.heightAnchor.constraint(equalToConstant: 60),
            
            scoreStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreStackView.topAnchor.constraint(equalTo: playerStackView.bottomAnchor, constant: 30),
            
            leaderboardButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            leaderboardButton.topAnchor.constraint(equalTo: scoreStackView.bottomAnchor, constant: 40),
            leaderboardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            leaderboardButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            leaderboardButton.heightAnchor.constraint(equalToConstant: 60),
            
            startNewGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startNewGameButton.topAnchor.constraint(equalTo: leaderboardButton.bottomAnchor, constant: 20),
            startNewGameButton.leadingAnchor.constraint(equalTo: leaderboardButton.leadingAnchor),
            startNewGameButton.trailingAnchor.constraint(equalTo: leaderboardButton.trailingAnchor),
            startNewGameButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
