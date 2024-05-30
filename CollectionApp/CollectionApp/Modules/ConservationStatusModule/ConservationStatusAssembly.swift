//
//  ConservationStatusAssembly.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

enum ConservationStatusAssembly {
    
    struct Dependencies {
        let viewController: UIViewController
    }

    struct Parameters {
        let consevation: BirdConservation
    }
    
    static func makeConservationStatusModule(dependencies: Dependencies,parameters: Parameters) -> UIViewController {
        let model = ConservationViewData(with: parameters.consevation)
        let router = ConservationStatusRouter(viewController: dependencies.viewController)
        let viewModel = ConservationStatusViewModel(router: router, birdConservationData: model)
        let viewController = ConservationStatusViewController(viewModel: viewModel)
        return viewController
    }
}

