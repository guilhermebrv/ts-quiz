//
//  ChooseEraView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

protocol ChooseEraViewProtocol: AnyObject {
    func tappedBackButton()
    func tappedStartGameButton()
}

class ChooseEraView: UIView {
    private weak var delegate: ChooseEraViewProtocol?
    public func delegate(delegate: ChooseEraViewProtocol?){
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
    
    @objc func tappedBackButton(_ sender: UILabel) {
        delegate?.tappedBackButton()
    }
    
    lazy var chooseFavoriteEraLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose your favorite era:"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Suisse Int'l Mono", size: 28)
        return label
    }()
    
    lazy var erasTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .bgGreen
        tableview.isUserInteractionEnabled = true
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(ChooseEraTableViewCell.self, forCellReuseIdentifier: ChooseEraTableViewCell.identifier)
        return tableview
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
        button.addTarget(self, action: #selector(tappedStartGameButton), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 254/255, green: 250/255, blue: 224/255, alpha: 1.0)
        return button
    }()
    
    @objc func tappedStartGameButton(_ sender: UILabel) {
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
    
    private func addElements() {
        addSubview(bgView)
        addSubview(backButton)
        addSubview(chooseFavoriteEraLabel)
        addSubview(erasTableView)
        addSubview(nextButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 90),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            
            chooseFavoriteEraLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            chooseFavoriteEraLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            chooseFavoriteEraLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            chooseFavoriteEraLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            erasTableView.topAnchor.constraint(equalTo: chooseFavoriteEraLabel.bottomAnchor, constant: 30),
            erasTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            erasTableView.widthAnchor.constraint(equalToConstant: 210),
            erasTableView.heightAnchor.constraint(equalToConstant: 420),

            nextButton.topAnchor.constraint(equalTo: erasTableView.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
