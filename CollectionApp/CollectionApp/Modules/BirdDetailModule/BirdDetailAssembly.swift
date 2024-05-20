//
//  BirdDetailAssembly.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

enum BirdDetailAssembly {
    
    struct Parameters {
        let bird: Bird
        let navigationTitle: String
    }
    
    struct Dependencies {
        let navigationController: UINavigationController
    }
    
    static func makeBirdDetailModule(dependencies: Dependencies, parameters: Parameters) -> UIViewController {
       // let router = BirdDetailRouter(navigationController: dependencies.navigationController)
        let router = BirdDetailRouter()
        let birdDetailViewData = BirdDetailViewData(with: parameters.bird)
        let presenter = BirdDetailPresenter(router: router, birdDetailViewData: birdDetailViewData)
        let viewController = BirdDetailViewController(presenter: presenter)
        return viewController
    }
}
