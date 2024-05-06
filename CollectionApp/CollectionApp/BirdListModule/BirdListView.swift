//
//  BirdListView.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdListView: UIView {
    
    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    // MARK: - UI Elements

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BirdCollectionViewCell.self, forCellWithReuseIdentifier: BirdCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    
    // MARK: - Setup method

    private func setupView() {
        addSubview(collectionView)
    }
}


// MARK: - Collection Layout Setup

private extension BirdListView {
    
    enum BirdListCollectionLayout {
        static let wideScreen: CGFloat = 500
        static let itemCountLanscape = 3
        static let itemCountPortrait = 2
        static let groupFractionalHeightLandscape = 0.7
        static let groupFractionalHeightPortrait = 0.33
        static let inset: CGFloat = 10
        static let groupSpacing: CGFloat = 20
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (_, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let isWide = layoutEnvironment.container.effectiveContentSize.width > BirdListCollectionLayout.wideScreen
            let itemCount = isWide ? BirdListCollectionLayout.itemCountLanscape : BirdListCollectionLayout.itemCountPortrait
            let groupFractionalHeight = isWide ? BirdListCollectionLayout.groupFractionalHeightLandscape : BirdListCollectionLayout.groupFractionalHeightPortrait
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(groupFractionalHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemCount)
            group.interItemSpacing = .fixed(BirdListCollectionLayout.groupSpacing)
  
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = BirdListCollectionLayout.groupSpacing
            section.contentInsets = NSDirectionalEdgeInsets(top: BirdListCollectionLayout.inset, leading: BirdListCollectionLayout.inset, bottom: BirdListCollectionLayout.inset, trailing: BirdListCollectionLayout.inset)
            return section
        }
        return layout
    }
}
