//
//  ChooseDifficultyViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/12/2023.
//

import Foundation

class ChooseDifficultyViewModel {
        
    public func saveDifficulty(_ difficulty: String) {
        UserDataModel.shared.saveDifficulty(difficulty)
    }
}
