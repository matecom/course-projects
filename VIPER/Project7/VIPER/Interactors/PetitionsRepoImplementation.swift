//
//  PetitionsRepoImplementation.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation

protocol PetitionsRepoProtocol {
    func fetchPetitionsList(completion: @escaping ([Petition]?) -> Void)
}

class PetitionsRepo: PetitionsRepoProtocol {
    
    func fetchPetitionsList(completion: @escaping ([Petition]?) -> Void) {
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
                        completion(nil)
                        return
                    }
                    completion(petitions)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
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
