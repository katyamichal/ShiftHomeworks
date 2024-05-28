//
//  BirdListViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

private enum BirdListSection {
    case birdList
}

final class BirdListViewController: UIViewController {

    private var birdListView: BirdListView { return self.view as! BirdListView }
    private let router: BirdListRouter
    private let dataSource: DataSourceProtocol
    private var collectionDiffableDataSource: UICollectionViewDiffableDataSource<BirdListSection, Bird>?
    private var snapshot = NSDiffableDataSourceSnapshot<BirdListSection, Bird>()

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
        self.view = BirdListView(collectionDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupNavigationBar()
        getBirdListData()
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
        let birds = dataSource.createSampleData()
        applySnapshot(with: BirdListViewData(with: birds))
    }
  
    // MARK: Collection Data Source

    func configureCollectionView() {
        collectionDiffableDataSource = UICollectionViewDiffableDataSource<BirdListSection, Bird>(collectionView: birdListView.collectionView) { (collectionView, indexPath, bird) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdCollectionViewCell.reuseIdentifier, for: indexPath) as? BirdCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateBirdImageView(bird.image)
            cell.updateBirdNameLabel(bird.name)
            return cell
        }
    }
    
    func applySnapshot(with model: BirdListViewData) {
        snapshot.appendSections([.birdList])
        snapshot.appendItems(model.birds, toSection: .birdList)
        collectionDiffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - Collection Delegate

extension BirdListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let bird = collectionDiffableDataSource?.itemIdentifier(for: indexPath) else { return }
        router.showBirdDetailScreen(with: bird)
    }
}


