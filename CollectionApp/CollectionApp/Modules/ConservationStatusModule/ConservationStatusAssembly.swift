//
//  ConservationStatusAssembly.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

enum ConservationStatusAssembly {
    
    struct Parameters {
        let consevation: BirdConservation
    }
    
    static func makeConservationStatusModule(parameters: Parameters) -> UIViewController {
        let model = ConservationViewData(with: parameters.consevation)
        let viewModel = ConservationStatusViewModel(birdConservation: model)
        let viewController = ConservationStatusViewController(viewModel: viewModel)
        return viewController
    }
}

