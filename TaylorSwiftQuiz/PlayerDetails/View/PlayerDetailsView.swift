//
//  SecondsScreenView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 23/09/2023.
//

protocol PlayerDetailsViewProtocol: AnyObject {
    func tappedChooseImage()
    func tappedNextStepButton()
}

import UIKit

class PlayerDetailsView: UIView {
    private weak var delegate: PlayerDetailsViewProtocol?
    public func delegate(delegate: PlayerDetailsViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 1.0)
        return view
    }()
    
    lazy var playerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, \nplayer!"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Suisse Int'l Mono", size: 33)
        return label
    }()
    
    lazy var playerNameTextField: UITextField = {
        let textfield = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Suisse Int'l Mono", size: 18.0)!,
            .foregroundColor: UIColor(red: 204/255, green: 213/255, blue: 174/255, alpha: 1.0)
        ]
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.attributedPlaceholder = NSAttributedString(string: "Insert your name", attributes: attributes)
        textfield.textColor = .black
        textfield.font = UIFont(name: "Apercu Mono", size: 20)
        textfield.textAlignment = .center
        textfield.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 30
        textfield.autocorrectionType = .no
        textfield.tintColor = .black
        return textfield
    }()
    
    lazy var alertMaxCharactersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maximum characters reached"
        label.textColor = .systemRed
        label.alpha = 0.0
        label.textAlignment = .center
        label.font = UIFont(name: "Suisse Int'l Mono", size: 10)
        return label
    }()
    
    lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose a photo, if you wish:"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Suisse Int'l Mono", size: 12)
        return label
    }()
    
    lazy var playerChooseImageButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "player-photo")
        let paintedimage = image?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(paintedimage, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 3
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 0.7)
        button.clipsToBounds = true
        button.layer.cornerRadius = 90
        button.addTarget(self, action: #selector(tappedChooseImage), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedChooseImage(_ sender: UIButton) {
        delegate?.tappedChooseImage()
    }
    
    lazy var nextStepButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 22)
        button.setTitleColor(.black.withAlphaComponent(0.2), for: .disabled)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(tappedNextStepButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        return button
    }()
    
    @objc func tappedNextStepButton(_ sender: UIButton) {
        delegate?.tappedNextStepButton()
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
        addSubview(playerNameLabel)
        addSubview(playerNameTextField)
        addSubview(alertMaxCharactersLabel)
        addSubview(photoLabel)
        addSubview(playerChooseImageButton)
        addSubview(nextStepButton)
    }
    
    public func animationMaxCharacters() {
        alertMaxCharactersLabel.text = "Maximum characters reached!"
        alertMaxCharactersLabel.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.alertMaxCharactersLabel.alpha = 0.7
        }
    }
    
    public func animationMinCharacters() {
        alertMaxCharactersLabel.text = "Minimum of 5 characters!"
        alertMaxCharactersLabel.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.alertMaxCharactersLabel.alpha = 0.7
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            playerNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
            playerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            playerNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            playerNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerNameTextField.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 30),
            playerNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            playerNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            playerNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            alertMaxCharactersLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertMaxCharactersLabel.topAnchor.constraint(equalTo: playerNameTextField.bottomAnchor, constant: 5),
            
            photoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoLabel.topAnchor.constraint(equalTo: alertMaxCharactersLabel.bottomAnchor, constant: 70),
            
            playerChooseImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerChooseImageButton.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 15),
            playerChooseImageButton.heightAnchor.constraint(equalToConstant: 180),
            playerChooseImageButton.widthAnchor.constraint(equalToConstant: 180),
            
            nextStepButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextStepButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            nextStepButton.leadingAnchor.constraint(equalTo: playerNameTextField.leadingAnchor),
            nextStepButton.trailingAnchor.constraint(equalTo: playerNameTextField.trailingAnchor),
            nextStepButton.heightAnchor.constraint(equalToConstant: 60),

        ])
    }
    
}
