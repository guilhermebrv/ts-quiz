//
//  ChooseEra2TableViewCell.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

//protocol ChooseEra2TableViewCellProtocol: AnyObject {
//    func tappedchooseEraButton()
//}

class ChooseEra2TableViewCell: UITableViewCell {

    //private weak var delegate: ChooseEra2TableViewCellProtocol?
   
    //public func delegate(delegate: ChooseEra2TableViewCellProtocol?){
    //    self.delegate = delegate
    //}
    
    static let identifier: String = "ChooseEra2TableViewCell"
    
   // override func awakeFromNib() {
   //     super.awakeFromNib()
   //     addElements()
   //     configConstraints()
   // }
    
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
        //button.layer.backgroundColor = UIColor.darkGray.cgColor
        //button.layer.borderWidth = 2
        button.alpha = 0.5
        button.clipsToBounds = true
        button.layer.cornerRadius = 190 / 2
        //button.addTarget(self, action: #selector(tappedchooseEraButton), for: .touchUpInside)
        return button
    }()
    
    //@objc func tappedchooseEraButton(_ sender: UILabel) {
    //    delegate?.tappedchooseEraButton()
     //   print("tocou")
    //}
        
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
