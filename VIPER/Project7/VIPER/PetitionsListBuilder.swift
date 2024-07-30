//
//  PetitionsListBuilder.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit

final class PetitionsListBuilder {

    class func build() -> PetitionsListRouter {
        let router = PetitionsListRouterImplementation()
        let repo = PetitionsRepoImplementation()
        let interactor = PetitionsListInteractor(repo: repo)
        let presenter = PetitionsListPresenterImplementation(router: router, interactor: interactor)
        let view = PetitionsListViewController(presenter: presenter)

        router.viewController = view
        interactor.output = presenter
        return router
    }
    

    

//    func presentPostDetailScreen(from view: PostListViewProtocol, forPost post: PostModel) {
//        let postDetailViewController = PostDetailWireFrame.createPostDetailModule(forPost: post)
//   
//        if let sourceView = view as? UIViewController {
//           sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
//        }
//    }
}
