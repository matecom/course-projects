//
//  PetitionsListPresenterImplementation.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit

protocol PetitionsListInteractorPresenterProtocol {
    func fetchPetitionsSuccess(petitionsList: [Petition])
    func fetchPetitionsFailure()
}

protocol PetitionsListViewControllerPresenterProtocol {
    func viewDidLoad(petitionsTag: Int)
    func showDetails(_ petition: Petition)
    func setFilter(_ filter: String)
}


class PetitionsListPresenter {

    private let view: PetitionsListViewProtocol
    private lazy var router: PetitionsListRouterProtocol = PetitionsListRouter(presenter: self)
    private lazy var interactor: PetitionsListInteractorProtocol = PetitionsListInteractor(presenter: self)

    init(view: PetitionsListViewProtocol) {
        self.view = view
    }
    
}

extension PetitionsListPresenter: PetitionsListInteractorPresenterProtocol {
    func fetchPetitionsSuccess(petitionsList: [Petition]) {
        self.view.show(petitionsList: petitionsList)
    }
    
    func fetchPetitionsFailure() {
        self.view.showError()
    }
}

extension PetitionsListPresenter: PetitionsListViewControllerPresenterProtocol {
    func setFilter(_ filter: String) {
        self.interactor.filter(filter)
    }
    
    func showDetails(_ petition: Petition) {
        router.presentDetails(parentViewController: view as! UIViewController, petition: petition)
    }
    
    func viewDidLoad(petitionsTag: Int) {
        self.interactor.fetchPetitionsList(petitionsTag: petitionsTag)
    }
}
