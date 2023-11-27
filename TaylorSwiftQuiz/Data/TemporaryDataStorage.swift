//
//  TemporaryDataStorage.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 26/09/2023.
//

import Foundation

class TemporaryDataStorage {
    static var shared = TemporaryDataStorage()
    var playerName: String = ""
    //var playerImage: Data?
    var difficultyLevel: String = ""
    var eraOption: String = ""
    var currentQuestion: Int = 1
    var currentPoints: Int = 0
    var currentOption: String = ""
}
