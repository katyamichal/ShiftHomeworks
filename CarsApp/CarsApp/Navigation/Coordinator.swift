//
//  Coordinator.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation
protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinator: [Coordinator] { get set }
    func start()
}
