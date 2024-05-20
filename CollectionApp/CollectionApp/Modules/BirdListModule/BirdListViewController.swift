//
//  BirdListViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdListViewController: UIViewController {

    private var birdListView: BirdListView { return self.view as! BirdListView }
    private let router: BirdListRouter
    private let dataSource: DataSourceProtocol
    private var birds: [Bird] = []

    // MARK: - Inits
    
    init(router: BirdListRouter, dataSource: DataSourceProtocol) {
        self.router = router
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cycle
    
    override func loadView() {
        self.view = BirdListView(collectionDelegate: self, dataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBirdListData()
        setupNavigationBar()
    }
}

// MARK: - Setup method



private extension BirdListViewController {
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Bird List"
    }
    
    func getBirdListData() {
       birds = dataSource.createSampleData()
    }
}

// MARK: - Collection Data Source

extension BirdListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        birds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdCollectionViewCell.reuseIdentifier, for: indexPath) as? BirdCollectionViewCell else {
            return UICollectionViewCell()
        }
        let bird = birds[indexPath.item]
        cell.updateBirdImageView(bird.image)
        cell.updateBirdNameLabel(bird.name)
        return cell
    }
}

// MARK: - Collection Delegate

extension BirdListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bird = birds[indexPath.item]
        router.showBirdDetailScreen(with: bird)
    }
}


