//
//  SplashViewController.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var splashImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        loadData()
    }
    
    private func configureViews() {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DataProvider.shared.loadCharacterObserver = nil
        super.viewWillDisappear(animated)
    }
    
    private func loadData() {
        //Cuando la carga de datos alcanza el 90% vamos a la pantalla principal
        DataProvider.shared.loadCharacterObserver = { [weak self] progress in
                print("\(progress * 100) %")
                
            if progress >= 0.9 {
                    self?.performSegue(withIdentifier: "FROM_SPLASH_TO_MAIN",
                                       sender: nil)
                }
        }
        
        // Load initial DATA
        DataProvider.shared.initData()
    }
}
