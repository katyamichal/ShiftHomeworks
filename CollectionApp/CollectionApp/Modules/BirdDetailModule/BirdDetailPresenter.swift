//
//  BirdDetailPresenter.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

enum BirdDetailSection: CaseIterable {
    case birdImage
    case birdInfo
}

protocol IBirdDetailPresenter: AnyObject {
    func didLoad(view: IBirdDetailView)
    func getSectionCount() -> Int
    func getItemsCountInSection(at section: Int) -> Int
    func itemForCell(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func showBirdConservationStatus()
}

final class BirdDetailPresenter {
    private weak var birdDetailView: IBirdDetailView?
    private let birdDetailViewData: BirdDetailViewData
    private let router: BirdDetailRouter
    private var bird: Bird?

    // MARK: - Init

    init(router: BirdDetailRouter, birdDetailViewData: BirdDetailViewData) {
        self.router = router
        self.birdDetailViewData = birdDetailViewData
    }
}

extension BirdDetailPresenter: IBirdDetailPresenter {
    func didLoad(view: IBirdDetailView) {
        birdDetailView = view
        bird = birdDetailViewData.bird
        birdDetailView?.setup(navigationTitle: bird?.name)
    }
    
    func getSectionCount() -> Int {
        BirdDetailSection.allCases.count
    }
    
    func getItemsCountInSection(at section: Int) -> Int {
        let section = BirdDetailSection.allCases[section]
        switch section {
        case .birdImage:
            return 1
        case .birdInfo:
            return birdDetailViewData.birdInfo.count
        }
    }
    
    func itemForCell(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let section = BirdDetailSection.allCases[indexPath.section]
        switch section {
        case .birdImage:
            return cell(for: collectionView, at: indexPath)
        case .birdInfo:
            return cell(for: collectionView, at: indexPath)
        }
    }
    
   private func cell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let section = BirdDetailSection.allCases[indexPath.section]
        switch section {
        case .birdImage:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdImageCell.reuseIdentifier, for: indexPath) as? BirdImageCell else {
                return UICollectionViewCell() }
            cell.updateImage(birdDetailViewData.birdImage)
            return cell
        case .birdInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdInfoCell.reuseIdentifier, for: indexPath) as? BirdInfoCell else {
                return UICollectionViewCell() }
            let info = birdDetailViewData.birdInfo[indexPath.item]
            cell.update(info: info)
            return cell
        }
    }
    
     func showBirdConservationStatus() {
        router.showConservationStatusModule(with: birdDetailViewData.birdConservation)
    }
}
