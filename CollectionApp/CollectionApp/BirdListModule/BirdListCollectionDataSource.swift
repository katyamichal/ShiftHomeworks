//
//  BirdListCollectionDataSource.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

enum BirdListSection {
    case birdList
}

final class BirdListCollectionDataSource: UICollectionViewDiffableDataSource<BirdListSection, Bird> {
    
    // MARK: - Init
    
    init(collectionView: UICollectionView) {
        defer {
            setupSnapshot()
        }
        super.init(collectionView: collectionView) { collectionView, indexPath, _ in
            Self.setupCell(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    // MARK: - Setup cell method
    
    private static func setupCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdCollectionViewCell.reuseIdentifier, for: indexPath) as? BirdCollectionViewCell else {
            return UICollectionViewCell()
        }
        let bird = BirdDataSource.birds[indexPath.item]
        cell.updateBirdImageView(bird.image)
        cell.updateBirdNameLabel(bird.name)
        return cell
    }
    
    private  func setupSnapshot() {
        var snapshot = self.snapshot()
        snapshot.appendSections([.birdList])
        snapshot.appendItems(BirdDataSource.birds, toSection: .birdList)
        apply(snapshot, animatingDifferences: false)
    }
}
