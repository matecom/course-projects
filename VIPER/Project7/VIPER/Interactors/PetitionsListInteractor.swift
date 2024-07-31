//
//  PetitionsListInteractor.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation

protocol PetitionsListInteractorProtocol {
    func fetchPetitionsList()
    func filter(_ filter: String)
}

class PetitionsListInteractor {
    private let repo: PetitionsRepoProtocol
    private let presenter: PetitionsListInteractorPresenterProtocol
    private var petitions: [Petition] = []
    
    init(presenter: PetitionsListInteractorPresenterProtocol) {
        self.repo = PetitionsRepo()
        self.presenter = presenter
    }
}

extension PetitionsListInteractor: PetitionsListInteractorProtocol {
    func fetchPetitionsList() {
        repo.fetchPetitionsList { petitions in
            if let petitions = petitions {
                self.presenter.fetchPetitionsSuccess(petitionsList: petitions)
                self.petitions = petitions
            } else {
                self.presenter.fetchPetitionsFailure()
            }
        }
    }
    
    func filter(_ filter: String) {
        if !filter.isEmpty {
            let petitions = self.petitions.filter { $0.title.contains(filter) }
            self.presenter.fetchPetitionsSuccess(petitionsList: petitions)
            
        } else {
            self.presenter.fetchPetitionsSuccess(petitionsList: self.petitions)
        }
    }
}
