//
//  BirdDetailView.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

enum BirdDetailSection: CaseIterable {
    case birdImage
    case birdInfo
}

final class BirdDetailView: UIView {
    
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
        collectionView.register(BirdImageCell.self, forCellWithReuseIdentifier: BirdImageCell.reuseIdentifier)
        collectionView.register(BirdInfoCell.self, forCellWithReuseIdentifier: BirdInfoCell.reuseIdentifier)
        return collectionView
    }()
    
    
    func setupDataSource(_ dataSource: BirdDetailCollectionDataSource) {
        collectionView.dataSource = dataSource
    }
    
    // MARK: - Setup method
    
    private func setupView() {
        addSubview(collectionView)
    }
}


// MARK: - Collection View Layout

private extension BirdDetailView {
    
    enum CollectionLayout {
        static let landscapeOrientation: CGFloat = 500
        static let groupHeightAbsoluteLanscape: CGFloat = 250
        static let groupHeightAbsolutePortrait: CGFloat = 350
        static let groupFractionalHeightLandscape = 0.5
        static let groupFractionalHeightPortrait = 1.0
        static let inset: CGFloat = 10
        static let groupSpacing: CGFloat = 20
    }
    
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > CollectionLayout.landscapeOrientation
            
            let sectionLayoutKind = BirdDetailSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .birdImage: return self.createBirdimageLayout(isWide: isWideView)
            case .birdInfo: return self.createBirdInfoLayout(isWide: isWideView)
            }
            
        }, configuration: config)
        return layout
    }
    
    
    func createBirdimageLayout(isWide: Bool) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth = isWide ? CollectionLayout.groupFractionalHeightLandscape : CollectionLayout.groupFractionalHeightPortrait
        let groupHeightAbsolute: CGFloat = isWide ? CollectionLayout.groupHeightAbsoluteLanscape : CollectionLayout.groupHeightAbsolutePortrait
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .absolute(groupHeightAbsolute))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createBirdInfoLayout(isWide: Bool) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupFractionalWidth = isWide ? 0.45 : 0.85
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 20)
        section.interGroupSpacing = 20
        return section
    }
}
