//
//  ViewController.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import UIKit

class CharacterViewController: UIViewController, CharacterListViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: CharacterListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = CharacterListViewModel(delegate: self)
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        viewModel?.viewDidLoad()
    }
    
    func characterListViewModelDelegateRefresh() {
        tableView.reloadData()
    }
    
}
extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let object = self.viewModel?.objectAt(indexPath: indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell {
                cell.configureCell(character: object)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let character = self.viewModel?.objectAt(indexPath: indexPath) {
                viewModel?.deleteCharacter(character)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showCharacterDetails(forRow: indexPath.row)
    }
}

extension CharacterViewController {
    func showCharacterDetails(forRow row: Int) {
//        let detailViewController = CharacterDetailsViewController()
//        let navigationController = UINavigationController(rootViewController: detailViewController)
//        navigationController.modalPresentationStyle = .fullScreen
//
//        // Obtener el personaje seleccionado
//        let selectedCharacter = viewModel?.getCharactersList()[row]
//
//        // Configurar los datos del personaje seleccionado
//        detailViewController.character = selectedCharacter
//
        //        present(navigationController, animated: true, completion: nil)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController {
            let selectedCharacter = viewModel?.getCharactersList()[row]
            
            vc.character = selectedCharacter
            self.present(vc, animated: true)
        }
    }
}

