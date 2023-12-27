//
//  ChooseEraTableViewCell.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import UIKit

class ChooseEraTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ChooseEraTableViewCell.self)
    private let screen: ChooseEraTableViewCellView = ChooseEraTableViewCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(screen)
        screen.pin(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseEraTableViewCell {
    public func setupCell(era: String) {
        screen.chooseEraButton.setBackgroundImage(UIImage(named: era), for: .normal)
    }
    public func selectEraEffect() {
        screen.chooseEraButton.alpha = 1.0
    }
    public func deselectEraEffect() {
        screen.chooseEraButton.alpha = 0.5
    }
}
