//
//  NetworkManager.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation
import Alamofire

// Se define la constante de la API de Rick and Morty

let baseURL = "https://rickandmortyapi.com/api"

// Constante que contiene la ruta para obtener un character especifico
let apiCharacterId = "/character/%@"

//Enum que representa el resultado de la llamada API
// Puede ser un exito con datos o un fallo  con mensaje
enum ServiceResult {
    case success(data: Any?)
    case failure(error: String?)
}

typealias ServiceCompletion = (_ result: ServiceResult) -> ()

class ApiService {
    
    static let shared = {
        ApiService()
    }()
    private init() {}
    
    // MARK: -Services-
    
    //Funcion que obtiene informacion de un character a partir de su id
    func fetchCharacter(by id: String, completion: @escaping ServiceCompletion){
        let urlCharacterId = String.init(format: apiCharacterId,
                                         arguments: [id])
        
        AF.request("\(baseURL)\(urlCharacterId)",
                   method: .get,
                   encoding: URLEncoding.default).responseDecodable { (response: DataResponse<Character, AFError>) in
            
            if let error = response.error {
                completion(.failure(error: error.localizedDescription))
            } else {
                completion(.success(data: response.value))
            }
        }
    }
}
