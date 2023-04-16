//
//  Character.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name, status, species, type, gender, image: String?
    
    var imageURL: String {
        if let image = self.image, !image.isEmpty {
            return image
        } else {
            return "https://rickandmortyapi.com/api/character/avatar/66.jpeg"
        }
    }
}
