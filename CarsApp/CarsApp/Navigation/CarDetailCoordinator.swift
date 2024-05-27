//
//  CarDetailCoordinator.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarDetailCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    private var navigationController: UINavigationController?
    
    private let factory: CarFactory
    private let id: Int
    private let service: CarServiceProtocol
    
    // MARK: - Init

    init(factory: CarFactory, id: Int, navigationController: UINavigationController?, service: CarServiceProtocol) {
        self.factory = factory
        self.id = id
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        showCarDetailScene(with: id)
    }
}

private extension CarDetailCoordinator {
    func showCarDetailScene(with id: Int) {
        let viewController = factory.makeCarDetailScene(dependencies: .init(coordinator: self, service: service), parameters: .init(id: id))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
