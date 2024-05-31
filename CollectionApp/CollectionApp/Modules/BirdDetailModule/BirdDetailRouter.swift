//
//  BirdDetailRouter.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

final class BirdDetailRouter {
    private let navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showConservationStatusModule(with conservationStatus: BirdConservation, viewController: UIViewController) {
        let parameters = ConservationStatusAssembly.Parameters(consevation: conservationStatus)
        let viewController = ConservationStatusAssembly.makeConservationStatusModule(dependencies: .init(viewController: viewController), parameters: .init(consevation: conservationStatus))
        navigationController.present(viewController, animated: true)
    }
}
