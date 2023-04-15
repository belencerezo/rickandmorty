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
}
