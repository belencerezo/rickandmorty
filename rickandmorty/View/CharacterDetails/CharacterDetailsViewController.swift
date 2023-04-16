//
//  cha.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameCharacter: UILabel!
    @IBOutlet weak var genderCharacter: UITextField!
    @IBOutlet weak var statusCharacter: UITextField!
    @IBOutlet weak var speciesCharacter: UITextField!
    @IBOutlet weak var typeCharacter: UITextField!
    @IBOutlet weak var characterDetailsView: UIView!
    
    // MARK: - Properties
    var character: CharacterEntity?
    private var viewModel = CharacterDetailsViewModel()
    weak var delegate: CharacterDetailsViewControllerDelegate?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        viewModel.configureImageView(mainImage: imageCharacter)
    }
    
    // MARK: - Private Functions
    func configureView() {
        if let character = character {
            imageCharacter.kf.setImage(with: URL(string: character.image ?? ""))
            nameCharacter.text = character.name
            genderCharacter.text = character.gender
            statusCharacter.text = character.status
            speciesCharacter.text = character.species
            typeCharacter.text = character.type
        }
    }
    
    // MARK: - IBActions
    @IBAction func typeTextFieldDidChange(_ sender: UITextField) {
        switch sender {
        case genderCharacter:
            character?.gender = sender.text ?? ""
        case statusCharacter:
            character?.status = sender.text ?? ""
        case speciesCharacter:
            character?.species = sender.text ?? ""
        case typeCharacter:
            character?.type = sender.text ?? ""
        default:
            break
        }
        // Guarda los cambios en CoreData
        viewModel.saveChanges()
        delegate?.characterDetailsViewControllerDidUpdateCharacter(self)
        
        // Actualiza la vista
        configureView()
    }
}
