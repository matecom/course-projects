//
//  PetitionsListRouterImplementation.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit

protocol PetitionsListRouterProtocol {
    func presentDetails(parentViewController: UIViewController, petition: Petition)
}

class PetitionsListRouter: PetitionsListRouterProtocol {
    private let presenter: PetitionsListPresenter
    
    init(presenter: PetitionsListPresenter) {
        self.presenter = presenter
    }
    
    func presentDetails(parentViewController: UIViewController, petition: Petition) {
        let petitionVC = PetitionDetailsViewController()
        petitionVC.setPetition(petition)
        parentViewController.navigationController?.pushViewController(petitionVC, animated: true)
    }
}
