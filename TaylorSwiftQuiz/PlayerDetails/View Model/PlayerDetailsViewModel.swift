//
//  PlayerDetailsViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 19/12/2023.
//

import UIKit

class PlayerDetailsViewModel {
    
	public func checkIfUserSelectedPhoto() -> Bool {
		if UserDataModel.shared.newPlayer?.photo == nil {
			UserDataModel.shared.saveCustomPhoto()
			return false
		} else {
			return true
		}
	}
    
    public func createNewPlayer() {
        UserDataModel.shared.saveNewPlayer()
    }
    
    public func savePlayerName(name: String, id: UUID) {
        UserDataModel.shared.savePlayerName(name, id)
    }
	
	public func savePlayerPhoto(photo: String) {
		UserDataModel.shared.savePlayerPhoto(photo)
	}
}
