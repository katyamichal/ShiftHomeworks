//
//  BirdDetailCollectionDataSource.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdDetailCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    private let bird: Bird
    
    private var birdInfo: [String] {
        [bird.description, bird.behavior, bird.physicalCharacteristics]
    }
    
    // MARK: - Init
    
    init(bird: Bird) {
        self.bird = bird
    }
    
    // MARK: - Collection Data Source
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        BirdDetailSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = BirdDetailSection.allCases[section]
        
        switch section {
        case .birdImage:
            return 1
        case .birdInfo:
            return birdInfo.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = BirdDetailSection.allCases[indexPath.section]
        
        switch section {
        case .birdImage:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdImageCell.reuseIdentifier, for: indexPath) as? BirdImageCell else {
                return UICollectionViewCell()
            }
            cell.updateImage(bird.image)
            return cell
            
        case .birdInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdInfoCell.reuseIdentifier, for: indexPath) as? BirdInfoCell else {
                return UICollectionViewCell()
            }
            let birdInfo = birdInfo[indexPath.item]
            cell.update(info: birdInfo)
            return cell
        }
    }
}
