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
        return view
    }()
    
    lazy var playerPhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 90 / 2
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.customWhite.cgColor
        image.layer.borderWidth = 2
        image.image = UIImage(named: "player-photo")
        image.backgroundColor = .customWhite
        return image
    }()
    
    lazy var playerName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.font = UIFont(name: "Suisse Int'l Mono", size: 30)
        return label
    }()
    
    lazy var scoredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.text = "You scored"
        label.textAlignment = .center
        label.font = UIFont(name: "Suisse Int'l Mono", size: 40)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(bgView)
        addSubview(playerPhoto)
        addSubview(playerName)
        addSubview(scoredLabel)
        addSubview(leaderboardButton)
        addSubview(startNewGameButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            playerPhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            playerPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            playerPhoto.widthAnchor.constraint(equalToConstant: 90),
            playerPhoto.heightAnchor.constraint(equalToConstant: 90),
            
            playerName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            playerName.leadingAnchor.constraint(equalTo: playerPhoto.trailingAnchor, constant: 10),
            playerName.trailingAnchor.constraint(equalTo: centerXAnchor),
            playerName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
}
