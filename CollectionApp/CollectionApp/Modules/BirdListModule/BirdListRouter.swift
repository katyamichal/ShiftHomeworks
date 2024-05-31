//
//  BirdListRouter.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

final class BirdListRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showBirdDetailScreen(with bird: Bird) {
        let parameters = BirdDetailAssembly.Parameters(bird: bird, navigationTitle: bird.name)
        let dependencies = BirdDetailAssembly.Dependencies(navigationController: navigationController)
        let viewController = BirdDetailAssembly.makeBirdDetailModule(dependencies: dependencies, parameters: parameters)
        navigationController.pushViewController(viewController, animated: true)
    }
}
