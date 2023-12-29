//
//  ChooseDifficultyViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/12/2023.
//

import Foundation

class ChooseDifficultyViewModel {
    
    private var model: UserDataModel = UserDataModel()
    
    public func saveDifficulty(_ difficulty: String) {
        model.saveDifficulty(difficulty)
    }
}
