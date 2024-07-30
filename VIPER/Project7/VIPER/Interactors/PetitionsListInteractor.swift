//
//  PetitionsListInteractor.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation

final class PetitionsListInteractor: PetitionsListInteractorInput {
    
    var output: PetitionsListInteractorOutput?

    private let repo: PetitionsRepo

    init(repo: PetitionsRepo) {
        self.repo = repo
    }
    
    func fetchPetitionsList() {
        repo.fetchPetitionsList { petitions, error in
            if let petitions = petitions {
                self.output?.fetchPetitionsSuccess(petitionsList: petitions)
            } else {
                self.output?.fetchPetitionsFailure(error: error)
            }
        }
    }
}
