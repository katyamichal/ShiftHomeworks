//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        let dataSource = BirdDataSourceImp()
        let dependencies = BirdListAssembly.Dependencies(navigationController: navigationController, dataSource: dataSource)
        let birdListViewController = BirdListAssembly.makeBirdListModule(with: dependencies)
        navigationController.viewControllers = [birdListViewController]
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

