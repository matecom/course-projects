//
//  PetitionsRepoImplementation.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation

public enum ApiError: Int, Error {
    case recieveNilResponse = 0,
    recieveErrorHttpStatus,
    recieveNilBody,
    failedParse
}

final class PetitionsRepoImplementation: PetitionsRepo {
    
    func fetchPetitionsList(completion: @escaping ([Petition]?, ApiError?) -> Void) {
//        if navigationController?.tabBarItem.tag == 0 {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
//        } else {
//            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
//        }
        var urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    guard let petitions = self.parse(json: data) else {
                        completion(nil, ApiError.failedParse)
                        return
                    }
                    completion(petitions, nil)
                } else {
                    completion(nil, ApiError.recieveNilBody)
                }
            } else {
                completion(nil, ApiError.recieveNilBody)
            }
        }
    }
    
    func parse(json: Data) -> [Petition]? {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            let petitionsJson = jsonPetitions.results
            return petitionsJson
        } else {
            return nil
        }
    }
}
