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


    func showConservationStatusModule(with conservationStatus: BirdConservation, view: UIViewController) {
        let parameters = ConservationStatusAssembly.Parameters(consevation: conservationStatus)
        let viewController = ConservationStatusAssembly.makeConservationStatusModule(parameters: parameters)
        view.present(viewController, animated: true)
    }
}
