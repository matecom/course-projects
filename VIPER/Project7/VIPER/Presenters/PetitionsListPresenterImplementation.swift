//
//  PetitionsListPresenterImplementation.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation

class PetitionsListPresenterImplementation: PetitionsListPresenter{

    private var view: PetitionsListView?
    private let router: PetitionsListRouter
    private let interactor: PetitionsListInteractorInput

    init(router: PetitionsListRouter, interactor: PetitionsListInteractor) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad(view: PetitionsListView) {
        self.view = view
        // Fetch the list from the interactor
        interactor.fetchPetitionsList()
    }
}

extension PetitionsListPresenterImplementation: PetitionsListInteractorOutput {
    func fetchPetitionsSuccess(petitionsList: [Petition]) {
        self.view?.show(petitionsList: petitionsList)
    }
    
    func fetchPetitionsFailure(error: ApiError?) {
        // show Error
    }
}
