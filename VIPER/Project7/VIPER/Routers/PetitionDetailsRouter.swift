//
//  PetitionDetailsRouter.swift
//  Project7
//
//  Created by Mateusz Bereta on 31/07/2024.
//

import Foundation
import UIKit

protocol PetitionDetailsRouterProtocol {

}

class PetitionDetailsRouter: PetitionDetailsRouterProtocol {
    private let presenter: PetitionDetailsPresenter
    
    init(presenter: PetitionDetailsPresenter) {
        self.presenter = presenter
    }
}
