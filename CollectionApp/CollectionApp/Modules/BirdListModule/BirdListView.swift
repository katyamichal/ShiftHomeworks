//
//  BirdListView.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdListView: UIView {
    
    // MARK: - Inits

    init(collectionDelegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        super.init(frame: .zero)
        setupView(collectionDelegate, dataSource)
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
        collectionView.register(BirdCollectionViewCell.self, forCellWithReuseIdentifier: BirdCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
}

// MARK: - Setup methods

private extension  BirdListView {
    
    func setupView(_ delegate: UICollectionViewDelegate, _ dataSource: UICollectionViewDataSource) {
        addSubview(collectionView)
        setupCollectionDataSource(dataSource)
        setupCollectionDelegate(delegate)
    }
    
    func setupCollectionDataSource(_ dataSource: UICollectionViewDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func setupCollectionDelegate(_ delegete: UICollectionViewDelegate) {
        collectionView.delegate = delegete
    }
}


// MARK: - Collection Layout Setup

private extension BirdListView {
    
    enum BirdListCollectionLayout {
        static let itemFractionalWidth = 0.5
        static let groupFractionalWidth = 0.65
        static let inset: CGFloat = 10
        static let groupSpacing: CGFloat = 20
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(BirdListCollectionLayout.itemFractionalWidth),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(BirdListCollectionLayout.groupFractionalWidth))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        group.interItemSpacing = .fixed(BirdListCollectionLayout.groupSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = BirdListCollectionLayout.groupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(top: BirdListCollectionLayout.inset, leading: BirdListCollectionLayout.inset, bottom: BirdListCollectionLayout.inset, trailing: BirdListCollectionLayout.inset)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
