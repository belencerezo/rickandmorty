//
//  cha.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var genderCharacter: UILabel!
    @IBOutlet weak var statusCharacter: UILabel!
    @IBOutlet weak var speciesCharacter: UILabel!
    @IBOutlet weak var typeCharacter: UILabel!
    @IBOutlet weak var characterDetailsView: UIView!
    
    
    // MARK: - Properties
    var character: CharacterEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    func configureView() {
        if let character = character {
            imageCharacter.layer.cornerRadius = imageCharacter.frame.height / 2
            imageCharacter.kf.setImage(with: URL(string: character.image ?? ""))
            nameCharacter.text = character.name
            genderCharacter.text = character.gender
            statusCharacter.text = character.status
            speciesCharacter.text = character.species
            typeCharacter.text = character.type
        }
    }
}
