//
//  QuestionsView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

protocol QuestionsViewProtocol: AnyObject {
    func tappedConfirmButton()
    func tappedNextButton()
    func tappedFirstOptionButton()
    func tappedSecondOptionButton()
    func tappedThirdOptionButton()
    func tappedStartNewGameButton()
}

class QuestionsView: UIView {
    private weak var delegate: QuestionsViewProtocol?
    public func delegate(delegate: QuestionsViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bgGreen
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
    
    lazy var playerName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.font = UIFont(name: "Suisse Int'l Mono", size: 15)
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.textAlignment = .right
        label.font = UIFont(name: "Suisse Int'l Mono", size: 18)
        return label
    }()
    
    lazy var questionNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.textAlignment = .center
        label.font = UIFont(name: "Suisse Int'l Mono", size: 30)
        return label
    }()
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.textAlignment = .center
        label.font = UIFont(name: "Apercu Mono", size: 23)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var firstOptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .customWhite
        button.layer.cornerRadius = 30 / 2
        button.addTarget(self, action: #selector(tappedFirstOptionButton), for: .touchUpInside)
        return button
    }()
    
    @objc public func tappedFirstOptionButton(_ sender: UIButton) {
        delegate?.tappedFirstOptionButton()
    }
    
    lazy var firstOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.font = UIFont(name: "Suisse Int'l Mono", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var secondOptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.backgroundColor = .customWhite
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 30 / 2
        button.addTarget(self, action: #selector(tappedSecondOptionButton), for: .touchUpInside)
        return button
    }()
    
    @objc public func tappedSecondOptionButton(_ sender: UIButton) {
        delegate?.tappedSecondOptionButton()
    }
    
    lazy var secondOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.font = UIFont(name: "Suisse Int'l Mono", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var thirdOptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .customWhite
        button.layer.cornerRadius = 30 / 2
        button.addTarget(self, action: #selector(tappedThirdOptionButton), for: .touchUpInside)
        return button
    }()
    
    @objc public func tappedThirdOptionButton(_ sender: UIButton) {
        delegate?.tappedThirdOptionButton()
    }
    
    lazy var thirdOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .customWhite
        label.font = UIFont(name: "Suisse Int'l Mono", size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirm answer", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 22)
        button.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
        button.backgroundColor = .customWhite
        return button
    }()
    
    @objc func tappedConfirmButton(_ sender: UIButton) {
        delegate?.tappedConfirmButton()
    }
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next question", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 22)
        button.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.backgroundColor = .customWhite
        return button
    }()
    
    @objc func tappedNextButton(_ sender: UIButton) {
        delegate?.tappedNextButton()
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
    
    @objc func tappedStartNewGameButton(_ sender: UIButton) {
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
        addSubview(pointsLabel)
        addSubview(questionNumberLabel)
        addSubview(questionLabel)
        addSubview(firstOptionButton)
        addSubview(firstOptionLabel)
        addSubview(secondOptionButton)
        addSubview(secondOptionLabel)
        addSubview(thirdOptionButton)
        addSubview(thirdOptionLabel)
        addSubview(confirmButton)
        addSubview(nextButton)
        addSubview(startNewGameButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            playerPhoto.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            playerPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            playerPhoto.widthAnchor.constraint(equalToConstant: 30),
            playerPhoto.heightAnchor.constraint(equalToConstant: 30),
            
            playerName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            playerName.leadingAnchor.constraint(equalTo: playerPhoto.trailingAnchor, constant: 10),
            playerName.trailingAnchor.constraint(equalTo: centerXAnchor),

            pointsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            pointsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            pointsLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            
            questionNumberLabel.topAnchor.constraint(equalTo: playerName.bottomAnchor, constant: 25),
            questionNumberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            questionLabel.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: 12),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            firstOptionButton.topAnchor.constraint(equalTo: firstOptionLabel.topAnchor),
            firstOptionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            firstOptionButton.widthAnchor.constraint(equalToConstant: 30),
            firstOptionButton.heightAnchor.constraint(equalToConstant: 30),
            
            firstOptionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 32),
            firstOptionLabel.leadingAnchor.constraint(equalTo: firstOptionButton.trailingAnchor, constant: 20),
            firstOptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            secondOptionButton.topAnchor.constraint(equalTo: secondOptionLabel.topAnchor),
            secondOptionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            secondOptionButton.widthAnchor.constraint(equalToConstant: 30),
            secondOptionButton.heightAnchor.constraint(equalToConstant: 30),
            
            secondOptionLabel.topAnchor.constraint(equalTo: firstOptionLabel.bottomAnchor, constant: 21),
            secondOptionLabel.leadingAnchor.constraint(equalTo: secondOptionButton.trailingAnchor, constant: 20),
            secondOptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            thirdOptionButton.topAnchor.constraint(equalTo: thirdOptionLabel.topAnchor),
            thirdOptionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            thirdOptionButton.widthAnchor.constraint(equalToConstant: 30),
            thirdOptionButton.heightAnchor.constraint(equalToConstant: 30),
            
            thirdOptionLabel.topAnchor.constraint(equalTo: secondOptionLabel.bottomAnchor, constant: 20),
            thirdOptionLabel.leadingAnchor.constraint(equalTo: thirdOptionButton.trailingAnchor, constant: 20),
            thirdOptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmButton.topAnchor.constraint(equalTo: thirdOptionLabel.bottomAnchor, constant: 30),
            confirmButton.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 60),
            
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            
            startNewGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startNewGameButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 20),
            startNewGameButton.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            startNewGameButton.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor),
            startNewGameButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
