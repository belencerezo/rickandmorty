//
//  CharacterListViewModel.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation
import CoreData
import UIKit

class CharacterListViewModel: NSObject {
    
    // MARK: - Properties
    var dataSource: [AnyObject] = []
    var delegate: CharacterListViewModelDelegate?
    
    private  var characters: [CharacterEntity] = []
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    init(delegate: CharacterListViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        characters = getCharacters()
    }
    
    // Lista de characters
    func getCharactersList() -> [CharacterEntity] {
       return characters
    }
    
    func refreshNetworkData() {
        self.delegate?.characterListViewModelDelegateRefresh()
    }
    
    func deleteCharacter(_ characterEntity: CharacterEntity) {
        context.delete(characterEntity)
        saveContext()
        characters = getCharacters()
        self.delegate?.characterListViewModelDelegateRefresh()
    }
    
    func getCharacters() -> [CharacterEntity] {
        let fetchRequest = NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
        do {
            // Guarda los personajes en la lista
            characters = try context.fetch(fetchRequest)
            
        } catch {
            print("Error fetching characters: \(error.localizedDescription)")
            
        }
        return characters
    }
    
    private func saveContext() {
        do {
            //Guarda los cambios en Core Data
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
            //Si hay personajes en la lista y fila solicitada
            //Devuelve el objecto de personaje
            return characters[indexPath.row]
        }
        return nil
    }
}

