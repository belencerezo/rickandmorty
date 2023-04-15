//
//  CharacterListViewModel.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation
import CoreData

class CharacterListViewModel: NSObject {
    var dataSource: [AnyObject] = []
    var delegate: CharacterListViewModelDelegate?
    
    private  var characters: [CharacterEntity] = []
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    init(delegate: CharacterListViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        characters = getCharacters()
    }
    
    func refreshNetworkData() {
        //self.characters = DataProvider.shared.defaultCharacter
        self.delegate?.characterListViewModelDelegateRefresh()
    }
    
    func deleteCharacter(_ characterEntity: CharacterEntity) {
        context.delete(characterEntity)
        saveContext()
        characters = getCharacters()
        self.delegate?.characterListViewModelDelegateRefresh()
    }
    
    func getCharacters() -> [CharacterEntity] {
        //characters = DataProvider.shared.defaultCharacter.sorted {($0.name ?? "") < ($1.name ?? "")}
        let fetchRequest = NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
        do {
            characters = try context.fetch(fetchRequest)
            
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
            
        }
        return characters
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }

    func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    func objectAt(indexPath: IndexPath) -> CharacterEntity? {
        if characters.count > indexPath.row {
            return characters[indexPath.row]
        }
        return nil
    }
}

