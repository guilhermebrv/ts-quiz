//
//  ChooseEraModalView.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

class ChooseEraModalView: UIView {
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 1.0)
        return view
    }()
    
    lazy var erasTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 1.0)
        return tableview
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
        addSubview(erasTableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: topAnchor),
            bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            erasTableView.topAnchor.constraint(equalTo: topAnchor),
            erasTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            erasTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            erasTableView.widthAnchor.constraint(equalToConstant: 320),
        ])
    }
    
}
