//
//  ChooseEraViewModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 27/12/2023.
//

import UIKit

class ChooseEraViewModel {
    public let eras: [String] = ["taylor-swift", "fearless", "speak-now", "red", "1989", "reputation", "lover", "folklore", "evermore", "midnights"]
    
    public func saveFavoriteEra(_ era: String) {
        UserDataModel.shared.saveEra(era)
    }
    
    public func getEraData() -> String {
        return UserDataModel.shared.newPlayer?.era ?? ""
    }
    
    public var numberOfRowsInSection: Int {
        return eras.count
    }
    
    public var heightForRowAt: CGFloat {
        return 210
    }
}
