//
//  NetworkManager.swift
//  rickandmorty
//
//  Created by Belén Cerezo on 15/4/23.
//

import Foundation
import Alamofire

let baseURL = "https://rickandmortyapi.com/api"

let apiCharacterId = "/character/%@"

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
