//
//  ErasTableViewCell.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 25/09/2023.
//

import UIKit

//protocol ErasTableViewCellProtocol: AnyObject {
//    func tappedChooseEraButton1(in cell: ErasTableViewCell)
//}

class ErasTableViewCell: UITableViewCell {
    
    //weak var delegate: ErasTableViewCellProtocol?
    
    //public func delegate(delegate: ErasTableViewCellProtocol?) {
    //    self.delegate = delegate
    //}
    
    static let identifier: String = "ErasTableViewCell"
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 233/255, green: 237/255, blue: 201/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var chooseEraButton1: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.alpha = 0.8
        button.clipsToBounds = true
        button.layer.cornerRadius = 150 / 2
        button.addTarget(self, action: #selector(tappedChooseEraButton1), for: .touchUpInside)
        return button
    }()
    
    @objc public func tappedChooseEraButton1() {
        print("button tapped in cell")
        //delegate?.tappedChooseEraButton1(in: self)
    }
    
    lazy var chooseEraButton2: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "person.fill"), for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.alpha = 0.8
        button.clipsToBounds = true
        button.layer.cornerRadius = 150 / 2
        //button.addTarget(self, action: #selector(tappedChooseImage), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addElements()
            configConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(bgView)
        addSubview(chooseEraButton1)
        addSubview(chooseEraButton2)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bgView.topAnchor.constraint(equalTo: self.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            chooseEraButton1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            chooseEraButton1.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            chooseEraButton1.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            chooseEraButton1.heightAnchor.constraint(equalToConstant: 150),
            chooseEraButton1.widthAnchor.constraint(equalToConstant: 150),
            
            chooseEraButton2.leadingAnchor.constraint(equalTo: chooseEraButton1.trailingAnchor, constant: 20),
            chooseEraButton2.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            chooseEraButton2.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            chooseEraButton2.heightAnchor.constraint(equalToConstant: 150),
            chooseEraButton2.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

}
