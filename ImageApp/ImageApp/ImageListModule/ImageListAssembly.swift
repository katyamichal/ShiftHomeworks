//
//  ImageListAssembly.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit
enum ImageListAssembly {
    
    struct Dependencies {
        let service: INetworkService
        let imageService: IImageService
    }
    
    static func makeImageListModule(dependencies: Dependencies) -> UIViewController {
        let presenter = ImageListPresenter(service: dependencies.service, imageService: dependencies.imageService)
        let viewController = ImageListViewController(presenter: presenter)
        return viewController
    }
}
