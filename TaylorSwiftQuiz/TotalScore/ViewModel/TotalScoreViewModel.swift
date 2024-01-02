//
//  TotalScoreViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 02/01/2024.
//

import UIKit

class TotalScoreViewModel {
    public func getFavoriteEra() -> String {
        return UserDataModel.shared.newPlayer?.era ?? ""
    }
    
    public func getPlayerName() -> String {
        return UserDataModel.shared.newPlayer?.name ?? ""
    }
    
    public func getCurrentPoints() -> Int16 {
        return UserDataModel.shared.newPlayer?.points ?? 0
    }
}
