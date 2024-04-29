//
//  TabBarViewController.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit

private enum TabBarImageView: String, CaseIterable {
    case firstTab = "person"
    case secondTab = "swiftdata"
    case thirdTab = "tree"
}

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private lazy var techSkillsViewController: TechSckillsViewController = {
        let controller = TechSckillsViewController()
        return controller
    }()
    
    private lazy var hobbyViewController: HobbyViewController = {
        let controller = HobbyViewController()
        return controller
    }()
    
    
    private func setupTabBar() {
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .systemGray
        viewControllers?.append(techSkillsViewController)
        viewControllers?.append(hobbyViewController)
        createTabBarItem(controllers: viewControllers)
    }
    
    private func createTabBarItem(controllers: [UIViewController]?) {
        guard let controllers else { return }
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 21, weight: .light)
        controllers.enumerated().forEach {index, controller in
            let imageName = TabBarImageView.allCases[index]
            let image = UIImage(systemName: imageName.rawValue, withConfiguration: configuration)
            let tabItem = UITabBarItem(title: nil, image: image, selectedImage: image)
            controller.tabBarItem = tabItem
        }
    }
}


