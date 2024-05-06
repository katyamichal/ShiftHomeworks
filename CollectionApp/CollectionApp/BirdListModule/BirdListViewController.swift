//
//  BirdListViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdListViewController: UIViewController {
    
    private var birdListView: BirdListView { return self.view as! BirdListView }
    private var birdsDataSource = BirdListCollectionViewDataSource()
    
    
    // MARK: - Inits

    override func loadView() {
        self.view = BirdListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Bird List"
        setupCollectionView()
    }
}

// MARK: - Setup method


private extension BirdListViewController {
    
    func setupCollectionView() {
        birdListView.collectionView.delegate = self
        birdsDataSource.setupDataSource( birdListView.collectionView)
    }
}

// MARK: - Collection Delegate


extension BirdListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = birdsDataSource.dataSource,  let bird = dataSource.itemIdentifier(for: indexPath) else { return }
        
        let detailViewController = BirdDetailViewController(birdDetailDataSource: BirdDetailCollectionDataSource(bird: bird))
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
