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
	var currentPlayer: Player?
    
    private init() { }
    
    public func saveNewPlayer() {
        newPlayer = Player(context: context)
		currentPlayer = newPlayer
        context.insert(newPlayer ?? Player())
    }
    
    public func savePlayerName(_ name: String, _ id: UUID) {
        newPlayer?.name = name
        newPlayer?.id = id
        //newPlayer?.photo = photo
        do {
            try context.save()
        } catch {
            print("error saving player name: \(error.localizedDescription)")
        }
    }
    
    public func saveDifficulty(_ difficulty: String) {
        newPlayer?.difficulty = difficulty
		switch difficulty {
		case "easy":
			newPlayer?.difficultyLevel = 1
		case "intermediate":
			newPlayer?.difficultyLevel = 2
		case "hard":
			newPlayer?.difficultyLevel = 3
		default:
			newPlayer?.difficultyLevel = Int16()
		}
        do {
            try context.save()
        } catch {
            print("error saving difficulty: \(error.localizedDescription)")
        }
    }
    
    public func saveEra(_ era: String) {
        newPlayer?.era = era
        newPlayer?.currentQuestion = 1
        do {
            try context.save()
        } catch {
            print("error saving favorite era: \(error.localizedDescription)")
        }
    }
    
    public func saveOption(_ option: String) {
        newPlayer?.selectedOption = option
        do {
            try context.save()
        } catch {
            print("error saving user selected option: \(error.localizedDescription)")
        }
    }
	
	public func countPlayers() -> Int {
		let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()

		do {
			let count = try context.count(for: fetchRequest)
			return count
		} catch {
			print("error counting number of saved players: \(error.localizedDescription)")
			return 0
		}
	}
    
    public func fetchPlayers() -> [Player] {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
		var players = [Player]()
        do {
			players = try context.fetch(fetchRequest)
        } catch {
			print("Error fetching players: \(error.localizedDescription)")
        }
		return players
    }

	public func deleteCurrentSessionData() {
		if let objectToDelete = currentPlayer {
			context.delete(objectToDelete)
			do {
				try context.save()
			} catch {
				print("error deleting object from CoreData")
			}
			currentPlayer = nil
		}
	}
}
