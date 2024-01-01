//
//  UserDataModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 28/12/2023.
//

import UIKit
import CoreData

class UserDataModel {
    static let shared = UserDataModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var newPlayer: Player?
    
    private init() {
        
    }
    
    public func saveNewPlayer() {
        newPlayer = Player(context: context)
        context.insert(newPlayer ?? Player())
    }
    
    public func savePlayerName(_ name: String, _ id: UUID) {
        newPlayer?.name = name
        newPlayer?.id = id
        //newPlayer?.photo = photo
        do {
            try context.save()
        } catch {
            print("error saving player name")
        }
    }
    
    public func saveDifficulty(_ difficulty: String) {
        newPlayer?.difficulty = difficulty
        do {
            try context.save()
        } catch {
            print("error saving difficulty")
        }
    }
    
    public func saveEra(_ era: String) {
        newPlayer?.era = era
        newPlayer?.currentQuestion = 1
        do {
            try context.save()
        } catch {
            print("error saving favorite era")
        }
    }
    
    public func saveOption(_ option: String) {
        newPlayer?.selectedOption = option
        do {
            try context.save()
        } catch {
            print("error saving user selected option")
        }
    }
    
    public func fetchPlayer() {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            let players = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching players: \(error)")
        }
    }

    public func saveData(saving: [Player]) {
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }

    public func readData() -> [Player] {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        var players = [Player]()
        do {
            players = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
        return players
    }
}
