//
//  TotalScoreViewController.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 02/01/2024.
//

import UIKit

class TotalScoreViewController: UIViewController {
    private var screen: TotalScoreView?
    private var viewModel: TotalScoreViewModel = TotalScoreViewModel()
    
    override func loadView() {
        screen = TotalScoreView()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signProtocols()
        setEraColor()
        setPlayerName()
        setCurrentPoints()
    }
}

extension TotalScoreViewController {
    private func signProtocols() {
        screen?.delegate(delegate: self)
    }
    private func setEraColor() {
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
        screen?.bgView.backgroundColor = eraColorMap[viewModel.getFavoriteEra()]
    }
    private func setPlayerName() {
        let name = viewModel.getPlayerName()
        screen?.playerName.text = name
    }
    private func setCurrentPoints() {
        let points = viewModel.getCurrentPoints()
        screen?.playerScoreLabel.text = String(points)
    }
}

extension TotalScoreViewController: TotalScoreViewProtocol {
    func tappedLeaderboardButton() {
        // let leaderboard = LeaderboardViewController()
        //navigationController?.pushViewController(leaderboard, animated: true)
    }
    
    func tappedStartNewGameButton() {
        navigationController?.popToRootViewController(animated: true)
    }
}
