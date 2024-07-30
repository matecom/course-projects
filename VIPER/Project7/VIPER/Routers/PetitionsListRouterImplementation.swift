//
//  PetitionsListRouterImplementation.swift
//  Project7
//
//  Created by Mateusz Bereta on 29/07/2024.
//

import Foundation
import UIKit

class PetitionsListRouterImplementation: PetitionsListRouter {    
    var viewController: UIViewController?
    
    func createWindow(windowScene: UIWindowScene) -> UIWindow {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(identifier: "PetitionsListVCID") // ViewController from storyboard
        let vc = UINavigationController(rootViewController: viewController!) // ViewController from router with navigationController
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return window
    }
}
