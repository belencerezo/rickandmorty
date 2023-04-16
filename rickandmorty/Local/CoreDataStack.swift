//
//  CoreDataStack.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation
import CoreData

class CoreDataStack {
    // MARK: - SINGLETON start -
    static let shared = CoreDataStack()
    
    private init() {}
    
    // MARK: - Core Data stack -
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataCharacter")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support -
    //Funcion para guardar los cambios realizados
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
