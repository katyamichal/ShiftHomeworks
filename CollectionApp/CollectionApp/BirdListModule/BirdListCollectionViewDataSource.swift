//
//  BirdListCollectionViewDataSource.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdListCollectionViewDataSource {
    
    enum BirdListSection {
        case birdList
    }
    
    private var birds: [Bird] = Bird.createSampleData()
    
    var dataSource: UICollectionViewDiffableDataSource<BirdListSection, Bird>?
     
    func setupDataSource(_ collectionView: UICollectionView) {
        dataSource = UICollectionViewDiffableDataSource<BirdListSection, Bird>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Bird) -> BirdCollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdCollectionViewCell.reuseIdentifier, for: indexPath) as! BirdCollectionViewCell
            let bird = self.birds[indexPath.item]
            cell.update(name: bird.name, imageName: bird.image)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<BirdListSection, Bird>()
        snapshot.appendSections([.birdList])
        snapshot.appendItems(birds, toSection: .birdList)
        guard let dataSource else { return }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
