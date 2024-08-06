//
//  PetitionDetailsPresenter.swift
//  Project7
//
//  Created by Mateusz Bereta on 31/07/2024.
//

import Foundation

protocol PetitionDetailsInteractorPresenterProtocol {

}

protocol PetitionDetailsViewControllerPresenterProtocol {
    
}


class PetitionDetailsPresenter {

    private let view: PetitionDetailsViewProtocol
    private lazy var router: PetitionDetailsRouter = PetitionDetailsRouter(presenter: self)
    private lazy var interactor: PetitionDetailsInteractor = PetitionDetailsInteractor(presenter: self)

    init(view: PetitionDetailsViewProtocol) {
        self.view = view
    }
}

extension PetitionDetailsPresenter: PetitionDetailsInteractorPresenterProtocol {

}

extension PetitionDetailsPresenter: PetitionDetailsViewControllerPresenterProtocol {

}
