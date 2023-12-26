//
//  FirstScreenView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 23/09/2023.
//

import UIKit

protocol FirstScreenViewProtocol: AnyObject {
    func tappedStartGameButton()
}

class FirstScreenView: UIView {
    
    private weak var delegate: FirstScreenViewProtocol?
    public func delegate(delegate: FirstScreenViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Taylor Swift"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Apercu Mono", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var name2Label: UILabel = {
        let label = UILabel()
        let labelText = " Quiz "
        let attributedstring = NSMutableAttributedString(string: labelText)
        attributedstring.addAttribute(NSAttributedString.Key.kern, value: 30.2, range: NSRange(location: 0, length: labelText.count))
        label.attributedText = attributedstring
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Suisse Int'l Mono", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "initial-image")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var startGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Game", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Suisse Int'l Mono", size: 30)
        button.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 0.7)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(tappedStartGameButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedStartGameButton(_ sender: UIButton) {
        delegate?.tappedStartGameButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func animateStartGameButton() {
        self.startGameButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.startGameButton.backgroundColor = .bgGreen
        }
    }
    
    public func tappedImageAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.imageView.frame.origin.x += 300
        }
    }
    
    public func imageInitialAnimation() {
        nameLabel.alpha = 0.0
        name2Label.alpha = 0.0
        imageView.alpha = 0.0
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1.5) {
            self.imageView.alpha = 1.0
            self.nameLabel.alpha = 1.0
            self.imageView.transform = CGAffineTransform.identity
        }
        UIView.animate(withDuration: 2.5) {
            self.name2Label.alpha = 1.0
        }
    }
    
    private func addElements() {
        addSubview(bgView)
        addSubview(nameLabel)
        addSubview(name2Label)
        addSubview(imageView)
        addSubview(startGameButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            
            name2Label.centerXAnchor.constraint(equalTo: centerXAnchor),
            name2Label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: name2Label.bottomAnchor, constant: 90),
            imageView.widthAnchor.constraint(equalToConstant: 333),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            startGameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startGameButton.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            startGameButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            startGameButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            startGameButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
