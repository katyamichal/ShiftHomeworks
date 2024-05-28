//
//  ConservationStatusAssembly.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

enum ConservationStatusAssembly {
    
    struct Dependencies {
        let navigationController: UINavigationController
    }

    struct Parameters {
        let consevation: BirdConservation
    }
    
    static func makeConservationStatusModule(dependencies: Dependencies,parameters: Parameters) -> UIViewController {
        let model = ConservationViewData(with: parameters.consevation)
        let router = ConservationStatusRouter(navigationController: dependencies.navigationController)
        let viewModel = ConservationStatusViewModel(router: router, birdConservationData: model)
        let viewController = ConservationStatusViewController(viewModel: viewModel)
        return viewController
    }
}

