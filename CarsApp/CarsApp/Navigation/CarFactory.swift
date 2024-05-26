//
//  CarFactory.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarFactory {
    
    struct Parameters {
        let id: Int
    }
    
    struct Dependencies {
        let coordinator: Coordinator
        let service: CarServiceProtocol
    }
    
    func makeNavigationController(with viewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: viewController)
    }
    
    func makeCarListScene(dependencies: Dependencies) -> UIViewController {
        let presenter = CarListPresenter(carService: dependencies.service)
        presenter.coordinator = dependencies.coordinator
        let viewController = CarListViewController(presenter: presenter)
        return viewController
    }
}
