//
//  SceneDelegate.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let dependencies = ImageListAssembly.Dependencies(service: NetworkService(), imageService: ImageService())
        let viewController = ImageListAssembly.makeImageListModule(dependencies: dependencies)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

