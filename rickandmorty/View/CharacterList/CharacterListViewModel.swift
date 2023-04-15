//
//  CharacterListViewModel.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation

protocol CharacterListViewModelDelegate: AnyObject {
    func characterListViewModelDelegateRefresh()
}

class CharacterListViewModel: NSObject {
    var dataSource: [AnyObject] = []
    weak var delegate: CharacterListViewModelDelegate?
    var characters: [Character] = []
    
    init(delegate: CharacterListViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func refreshNetworkData() {
        self.characters = DataProvider.shared.defaultCharacter
        self.delegate?.characterListViewModelDelegateRefresh()
    }
    
    func getCharacter() {
        characters = DataProvider.shared.defaultCharacter.sorted {($0.name ?? "") < ($1.name ?? "")}
    }

    func numberOfRowsInSection() -> Int {
        return characters.count
    }
    
    func objectAt(indexPath: IndexPath) -> Character? {
        if characters.count > indexPath.row {
            return characters[indexPath.row]
        }
        return nil
    }
}

