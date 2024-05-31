//
//  ConservationStatusRouter.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

final class ConservationStatusRouter {
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func goBack() {
        viewController.dismiss(animated: true)
    }
}
