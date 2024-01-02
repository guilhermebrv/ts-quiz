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
}
