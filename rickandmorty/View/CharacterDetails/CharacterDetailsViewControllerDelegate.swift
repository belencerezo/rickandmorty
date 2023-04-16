//
//  CharacterDetailsViewControllerDelegate.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 16/4/23.
//

import Foundation

protocol CharacterDetailsViewControllerDelegate: AnyObject {
    func characterDetailsViewControllerDidUpdateCharacter(_ viewController: CharacterDetailsViewController)
}
