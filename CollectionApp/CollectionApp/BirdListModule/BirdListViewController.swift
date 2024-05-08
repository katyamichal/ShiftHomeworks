//
//  BirdListViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdListViewController: UIViewController {
    
    private var birdListView: BirdListView { return self.view as! BirdListView }

    // MARK: - Inits

    override func loadView() {
        self.view = BirdListView(collectionDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

// MARK: - Setup method


private extension BirdListViewController {

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Bird List"
    }
}


// MARK: - Collection Delegate

extension BirdListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bird = BirdDataSource.birds[indexPath.item]
        let detailViewController = BirdDetailViewController(birdDetailDataSource: BirdDetailCollectionDataSource(bird: bird), navigationTitle: bird.name, birdConservation: bird.birdConservation)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
