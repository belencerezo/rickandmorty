//
//  DataProvider.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation

class DataProvider {
    // MARK: - SINGLETON start -
    /// The static field that controls the access to the DataProvider instance.
    /// This implementation let you extend the DataProvider class while keeping
    /// just one instance of each subclass around.
    static var shared: DataProvider = {
        return DataProvider()
    }()
    
    /// The DataProvider's initializer should always be private to prevent direct
    /// construction calls with the `new` operator.
    private init() {}
    // MARK: - SINGLETON end -
    
    var defaultCharacter: [Character] = []
    
    //************* LOAD JSON DATA ****************
    
    //Creamos un maximo de character
    private let characterMaxCount = 100
    //Analizamos por que numero de character va la lista
    var loadCharacterObserver: ((_ progress: Float) -> ())? = nil
    var loadCharacterCount = 0 {
            didSet {
                loadCharacterObserver?(Float(loadCharacterCount) / Float(characterMaxCount))
            }
        }
    
    func initData() {
        for id in 0...characterMaxCount {
            ApiService.shared.fetchCharacter(by: "\(id)") { [weak self] result in
                switch result {
                case .success(let data):
                    guard let character = data as? Character,
                          !(character.id == nil) else {
                        return
                    }
                    // Añadimos los characters a la lista y los guardamos en CoreData
                    self?.defaultCharacter.append(character)
                    self?.saveCharacters()
                    
                case .failure(_):
                    break
                }
                
                //Añadimos uno mas en la lista para saber cuantos hemos guardado
                self?.loadCharacterCount += 1
            }
        }
    }
    
    //************* SAVE CHARACTERS TO CORE DATA ****************
    
    private func saveCharacters() {
            let context = CoreDataStack.shared.persistentContainer.viewContext
            context.perform {
                do {
                    for character in self.defaultCharacter {
                        let entity = CharacterEntity(context: context)
                        entity.id = Int32(character.id ?? 0)
                        entity.name = character.name
                        entity.status = character.status
                        entity.species = character.species
                        entity.type = character.type
                        entity.gender = character.gender
                        entity.image = character.imageURL
                    }
                    
                    try context.save()
                } catch {
                    print("Error saving characters to Core Data: \(error.localizedDescription)")
            }
        }
    }
}
