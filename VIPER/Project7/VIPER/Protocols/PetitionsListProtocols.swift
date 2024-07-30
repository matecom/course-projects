//
//  PetitonsListProtocols.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit


protocol PetitionsListView {
    func show(petitionsList: [Petition])
}

protocol PetitionsListPresenter {
    func viewDidLoad(view: PetitionsListView)
}

protocol PetitionsListInteractorInput {
    func fetchPetitionsList()
}

protocol PetitionsListInteractorOutput {
    func fetchPetitionsSuccess(petitionsList: [Petition])
    func fetchPetitionsFailure(error: ApiError?)
}

protocol PetitionsRepo {
    func fetchPetitionsList(completion: @escaping ([Petition]?, ApiError?) -> Void)
}

protocol PetitionsListRouter {
    var viewController: UIViewController? { get set }
    
    func createWindow(windowScene: UIWindowScene) -> UIWindow
}
