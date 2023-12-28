//
//  UserDataModel.swift
//  TaylorSwiftQuiz
//
//  Created by Guilherme Viana on 28/12/2023.
//

import UIKit
import CoreData

class UserDataModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    public func saveData(saving: [Player]) {
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }
    
    public func saveNameData(saving name: [Player]) {
        for player in name {
            player.name = name
        }
        do {
            try context.save()
        } catch {
            print("error saving context - \(error.localizedDescription)")
        }
    }

    public func readData(initialItems: [Player]) -> [Player] {
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        var items = initialItems
                
        do {
            items = try context.fetch(request)
        } catch {
            print("error fetching data from context - \(error.localizedDescription)")
        }
        return items
    }
}
