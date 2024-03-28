//
//  NetworkAPI.swift
//  DBZCharacters
//
//  Created by New on 26/03/24.
//

import Foundation

enum APError: Error{
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
    
}


class NetworkAPI {
    
    static let shared = NetworkAPI()
    
    static let urlBase = "https://dragonball-api.com/api/characters?page="
    func getCharacter(numberPage: Int, completed: @escaping (Result<DBZModel, APError>) -> Void){
        
        guard let url = URL(string: NetworkAPI.urlBase+"\(numberPage)") else{
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response , error in
           // desenvolver el error
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            //desenvolver la respuesta
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            //desenvolver la data
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(DBZModel.self, from: data)
                completed(.success(decodedResponse))
            }catch{
                print("debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
