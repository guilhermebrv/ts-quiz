//
//  ChooseDifficultyView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

protocol ChooseDifficultyViewProtocol: AnyObject {
    func tappedBackButton()
    func tappedNextButton()
    func tappedEasyButton()
    func tappedIntermediateButton()
    func tappedHardButton()
}

class ChooseDifficultyView: UIView {
    
    private weak var delegate: ChooseDifficultyViewProtocol?
    
    public func delegate(delegate: ChooseDifficultyViewProtocol?) {
        self.delegate = delegate
    }

    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 1.0)
        return view
    }()
    
    lazy var backButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 18)
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc public func tappedBackButton(_ sender: UIButton) {
        delegate?.tappedBackButton()
    }
    
    lazy var chooseDifficultyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose your difficulty level:"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Suisse Int'l Mono", size: 28)
        return label
    }()
    
    lazy var easyButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        button.layer.cornerRadius = 30 / 2
        button.addTarget(self, action: #selector(tappedEasyButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc public func tappedEasyButton(_ sender: UIButton) {
        delegate?.tappedEasyButton()
    }
    
    lazy var easyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Easy"
        label.textColor = .black
        label.font = UIFont(name: "Suisse Int'l Mono", size: 20)
        return label
    }()
    
    lazy var intermediateButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 30 / 2
        button.addTarget(self, action: #selector(tappedIntermediateButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc public func tappedIntermediateButton(_ sender: UIButton) {
        delegate?.tappedIntermediateButton()
    }
    
    lazy var intermediateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Intermediate"
        label.textColor = .black
        label.font = UIFont(name: "Suisse Int'l Mono", size: 20)
        return label
    }()
    
    lazy var hardButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        button.layer.cornerRadius = 30 / 2
        button.addTarget(self, action: #selector(tappedHardButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc public func tappedHardButton(_ sender: UIButton) {
        delegate?.tappedHardButton()
    }
    
    lazy var hardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hard"
        label.textColor = .black
        label.font = UIFont(name: "Suisse Int'l Mono", size: 20)
        return label
    }()
    
    lazy var nextButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 22)
        button.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        
        return button
    }()
    
    @objc public func tappedNextButton() {
        delegate?.tappedNextButton()
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
        addSubview(backButton)
        addSubview(chooseDifficultyLabel)
        addSubview(easyButton)
        addSubview(easyLabel)
        addSubview(intermediateButton)
        addSubview(intermediateLabel)
        addSubview(hardButton)
        addSubview(hardLabel)
        addSubview(nextButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 90),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            
            chooseDifficultyLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            chooseDifficultyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            chooseDifficultyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            chooseDifficultyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            easyButton.topAnchor.constraint(equalTo: chooseDifficultyLabel.bottomAnchor, constant: 80),
            easyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            easyButton.widthAnchor.constraint(equalToConstant: 30),
            easyButton.heightAnchor.constraint(equalToConstant: 30),
            
            easyLabel.topAnchor.constraint(equalTo: chooseDifficultyLabel.bottomAnchor, constant: 82),
            easyLabel.leadingAnchor.constraint(equalTo: easyButton.trailingAnchor, constant: 30),
            easyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            intermediateButton.topAnchor.constraint(equalTo: easyButton.bottomAnchor, constant: 60),
            intermediateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            intermediateButton.widthAnchor.constraint(equalToConstant: 30),
            intermediateButton.heightAnchor.constraint(equalToConstant: 30),
            
            intermediateLabel.topAnchor.constraint(equalTo: easyLabel.bottomAnchor, constant: 64),
            intermediateLabel.leadingAnchor.constraint(equalTo: intermediateButton.trailingAnchor, constant: 30),
            intermediateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            hardButton.topAnchor.constraint(equalTo: intermediateButton.bottomAnchor, constant: 60),
            hardButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            hardButton.widthAnchor.constraint(equalToConstant: 30),
            hardButton.heightAnchor.constraint(equalToConstant: 30),
            
            hardLabel.topAnchor.constraint(equalTo: intermediateLabel.bottomAnchor, constant: 64),
            hardLabel.leadingAnchor.constraint(equalTo: hardButton.trailingAnchor, constant: 30),
            hardLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            nextButton.topAnchor.constraint(equalTo: hardLabel.bottomAnchor, constant: 90),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: chooseDifficultyLabel.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: chooseDifficultyLabel.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 60),



        ])
    }
    
}
