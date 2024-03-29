//
//  LeaderboardTableViewCell.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 03/01/2024.
//

import UIKit
import RealmSwift

class LeaderboardTableViewCell: UITableViewCell {
	static let identifier: String = String(describing: LeaderboardTableViewCell.self)
	private let screen: LeaderboardTableViewCellView = LeaderboardTableViewCellView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(screen)
		screen.pin(to: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension LeaderboardTableViewCell {
	public func setupCell(player: PlayerRealm) {
		let eraColorMap: [String: UIColor] = [
				"taylor-swift": .taylorswift,
				"fearless": .fearless,
				"speak-now": .speaknow,
				"red": .tsred,
				"1989": .ts1989,
				"reputation": .reputation,
				"lover": .lover,
				"folklore": .folklore,
				"evermore": .evermore,
				"midnights": .midnights]
		screen.bgView.backgroundColor = eraColorMap[player.era]
		screen.playerNameLabel.text = player.name
		if player.rank != 0 {
			screen.playerPositionLabel.text = "#\(player.rank)"
		}
		screen.playerDifficultyLabel.text = player.difficulty
		screen.playerScoreButton.setTitle(String(player.points), for: .normal)
		if player.photo != "custom" {
			if let data = Data(base64Encoded: player.photo) {
				let image = UIImage(data: data)
				screen.playerPhoto.image = image
			}
		} else {
			screen.playerPhoto.image = UIImage(named: "player-photo")
		}
	}
}
