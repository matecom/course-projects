//
//  PetitionDetailsInteractor.swift
//  Project7
//
//  Created by Mateusz Bereta on 31/07/2024.
//

import Foundation

protocol PetitionDetailsInteractorProtocol {
    
}


class PetitionDetailsInteractor {
    private let presenter: PetitionDetailsPresenter
    
    init(presenter: PetitionDetailsPresenter) {
        self.presenter = presenter
    }
}


extension PetitionDetailsInteractor: PetitionDetailsInteractorProtocol {
    
}
