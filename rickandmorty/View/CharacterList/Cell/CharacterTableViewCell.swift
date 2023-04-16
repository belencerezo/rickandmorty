//
//  CharacterTableViewCell.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(character: CharacterEntity) {
        characterImageView.kf.setImage(with: URL(string: character.image ?? ""))
        characterName.text = character.name
        characterGender.text = character.gender
    }
}
