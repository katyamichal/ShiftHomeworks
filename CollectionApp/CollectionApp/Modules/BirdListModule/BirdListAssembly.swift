//
//  BirdListAssembly.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

enum BirdListAssembly {
    
    struct Dependencies {
        let navigationController: UINavigationController
        let dataSource: DataSourceProtocol
    }
    
    static func makeBirdListModule(with dependencies: Dependencies) -> UIViewController {
        let router = BirdListRouter(navigationController: dependencies.navigationController)
        let birdDataSource = BirdDataSourceImp()
        let viewController = BirdListViewController(router: router, dataSource: birdDataSource)
        return viewController
    }
}
