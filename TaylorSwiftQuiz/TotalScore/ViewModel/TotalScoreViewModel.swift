//
//  TotalScoreViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 02/01/2024.
//

import UIKit
import RealmSwift

class TotalScoreViewModel {
	private let realmService = RealmService()
	
	public func saveDataToRealm() async {
		await realmService.saveRealmService()
	}
	
    public func getFavoriteEra() -> String {
        return UserDataModel.shared.newPlayer?.era ?? ""
    }
    
    public func getPlayerName() -> String {
        return UserDataModel.shared.newPlayer?.name ?? ""
    }
    
    public func getCurrentPoints() -> Int32 {
        return UserDataModel.shared.newPlayer?.points ?? 0
    }
}
