//
//  ViewController.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import UIKit

class CharacterViewController: UIViewController, CharacterListViewModelDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: CharacterListViewModel?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel = CharacterListViewModel(delegate: self)
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        viewModel?.viewDidLoad()
    }
    
    // MARK: - CharacterListViewModelDelegate
    func characterListViewModelDelegateRefresh() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
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

// MARK: - Navigation
extension CharacterViewController {
    func showCharacterDetails(forRow row: Int) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController {
            let selectedCharacter = viewModel?.getCharactersList()[row]
            vc.delegate = self
            vc.character = selectedCharacter
            self.present(vc, animated: true)
        }
    }
}

// MARK: - CharacterDetailsViewControllerDelegate
extension CharacterViewController: CharacterDetailsViewControllerDelegate {
    func characterDetailsViewControllerDidUpdateCharacter(_ viewController: CharacterDetailsViewController) {
        characterListViewModelDelegateRefresh()
    }
}
