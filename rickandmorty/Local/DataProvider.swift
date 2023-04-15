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
    
    private let characterMaxCount = 100
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
                    self?.defaultCharacter.append(character)
                    
                case .failure(_):
                    break
                }
                
                self?.loadCharacterCount += 1
            }
        }
    }
}
