//
//  BirdDetailView.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

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
    
   private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BirdImageCell.self, forCellWithReuseIdentifier: BirdImageCell.reuseIdentifier)
        collectionView.register(BirdInfoCell.self, forCellWithReuseIdentifier: BirdInfoCell.reuseIdentifier)
        return collectionView
    }()
    
    func setupCollectionDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
}

private extension BirdDetailView {    
    private func setupView() {
        addSubview(collectionView)
    }
}

// MARK: - Collection View Layout

private extension BirdDetailView {
    enum DetailCollectionLayout {
        static let wideScreen: CGFloat = 500
        static let itemCountLanscape = 3
        static let itemCountPortrait = 2
        static let imageGroupHeightPortrait = 0.45
        static let infoGroupHeightPortrait = 0.85
        static let infoGroupHeightLandscape = 0.45
        static let inset: CGFloat = 10
        static let spacing: CGFloat = 20
    }
        
    func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = DetailCollectionLayout.spacing
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > DetailCollectionLayout.wideScreen
            
            let sectionLayoutKind = BirdDetailSection.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .birdImage: return self.createBirdImageLayout(isWide: isWideView)
            case .birdInfo: return self.createBirdInfoLayout(isWide: isWideView)
            }
            
        }, configuration: config)
        return layout
    }
    
    func createBirdImageLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalHeight: CGFloat = isWide ?  1.0 : DetailCollectionLayout.imageGroupHeightPortrait
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(groupFractionalHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createBirdInfoLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth = isWide ? DetailCollectionLayout.infoGroupHeightLandscape : DetailCollectionLayout.infoGroupHeightPortrait
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .fractionalWidth(groupFractionalWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: DetailCollectionLayout.inset, bottom: DetailCollectionLayout.inset, trailing: DetailCollectionLayout.spacing)
        section.interGroupSpacing = DetailCollectionLayout.spacing
        return section
    }
}
