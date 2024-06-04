//
//  AppCoordinator.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    let window: UIWindow
    
    private let factory: CarFactory
    private var navigationController: UINavigationController?
    private let service: CarServiceProtocol
    
    // MARK: - Init
    
    init(window: UIWindow, factory: CarFactory, service: CarServiceProtocol) {
        self.window = window
        self.factory = factory
        self.service = service
    }
    
    func start() {
        showCarListScene()
    }
    
    func showCarDetailScene(with id: Int) {
        let detailCoordinator = CarDetailCoordinator(factory: factory, id: id, navigationController: navigationController, service: service)
        detailCoordinator.parentCoordinator = self
        self.childCoordinator.append(detailCoordinator)
        detailCoordinator.start()
    }
}

private extension AppCoordinator {
    func showCarListScene() {
        let viewController = factory.makeCarListScene(dependencies: .init(coordinator: self, service: service))
        let navigationController = factory.makeNavigationController(with: viewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
