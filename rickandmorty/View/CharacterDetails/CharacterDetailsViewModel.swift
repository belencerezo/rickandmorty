//
//  CharacterDetailsViewModel.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 16/4/23.
//

import UIKit

class CharacterDetailsViewModel {
    
    private var character: CharacterEntity?
    private let context = CoreDataStack.shared.persistentContainer.viewContext
    
    // MARK: - Methods
    
    func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Error al guardar los cambios en CoreData: \(error)")
        }
    }
    
    func configureImageView(mainImage: UIImageView) {
        mainImage.layer.cornerRadius = mainImage.frame.height / 2
        mainImage.layer.borderWidth = 1
        mainImage.clipsToBounds = true
        
        let smallImage = UIImageView(image: UIImage(named: "smallImage"))
        let smallImageSize: CGFloat = 50
        smallImage.frame = CGRect(x: 90, y: 93, width: smallImageSize, height: smallImageSize)
        
        mainImage.superview?.addSubview(smallImage)
    }
}
