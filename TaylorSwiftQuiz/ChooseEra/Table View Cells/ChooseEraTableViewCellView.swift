//
//  ChooseEraTableViewCellView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 27/12/2023.
//

import UIKit

class ChooseEraTableViewCellView: UIView {
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var chooseEraButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.alpha = 0.5
        button.clipsToBounds = true
        button.layer.cornerRadius = 190 / 2
        return button
    }()
    
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
        addSubview(chooseEraButton)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            chooseEraButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chooseEraButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            chooseEraButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            chooseEraButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chooseEraButton.heightAnchor.constraint(equalToConstant: 190),
            chooseEraButton.widthAnchor.constraint(equalToConstant: 190),
        ])
    }
}
