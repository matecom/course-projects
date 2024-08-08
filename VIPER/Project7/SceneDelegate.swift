//
//  SceneDelegate.swift
//  Project7
//
//  Created by Mateusz Bereta on 16/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        changeBackgroundColorForNavigationBar()
        if let tabBarController = window?.rootViewController as? UITabBarController {
            tabBarController.viewControllers?.append(getNavController(tabBarSystemItem: .topRated))
        }
    }
    
    func getNavController(tabBarSystemItem: UITabBarItem.SystemItem) -> UIViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tabBarSystemItem.rawValue)
        return vc
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func changeBackgroundColorForNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithOpaqueBackground()
                navigationBarAppearance.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]
                navigationBarAppearance.backgroundColor = .accent
        
                UINavigationBar.appearance().tintColor = .white
                UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
}

