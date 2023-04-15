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
    
//    func fetchAllCharacters(completion: [Character]) {
//        let pagesCharacter = "/character/?page=2"
//        let baseUrl = "https://rickandmortyapi.com/api" + pagesCharacter
//
//        AF.request(baseUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let jsonData = try JSONDecoder().decode([ApiRequest].self, from: data!)
//                    print(jsonData)
//
//                } catch {
//                    print(error.localizedDescription)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
//        AF.request(baseUrl,
//                           method: .get,
//                           encoding: URLEncoding.default).responseDecodable { (response: DataResponse<Character, AFError>) in
//
//                    if let error = response.error {
//                        print(error.localizedDescription)
//                    } else {
//                        completion(.success(data: response.value))
//                    }
//                }
//    }
    
    

//    func getCharacters(byId id: String, completion: @escaping (Character?) -> Void) {
//        let pagesCharacter = "/character/?page=2"
//        let baseUrl = "https://rickandmortyapi.com/api" + pagesCharacter
//        
//        Alamofire
//        
//        Alamofire.request(baseUrl).response { response in
//            guard let data = response.data else { return }
//            do {
//                let decoder = JSONDecoder()
//                let characterRequest = try decoder.decode(Character.self, from: data)
//                completion(characterRequest)
//            } catch let error {
//                print(error)
//                completion(nil)
//            }
//        }
//    }
}
