//
//  PlayerDetailsViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 19/12/2023.
//

import UIKit

class PlayerDetailsViewModel {
    
    private var model: UserDataModel = UserDataModel()
    //private var player: [Player] = [Player]()
    
    public func createNewPlayer() {
        model.saveNewPlayer()
    }
    
    public func savePlayerName(name: String, id: UUID) {
        model.savePlayerName(name, id)
    }
}
