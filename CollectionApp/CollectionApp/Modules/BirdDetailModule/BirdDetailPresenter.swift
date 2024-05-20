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
    private let birdDetailModel: BirdDetailModel
    private let router: BirdDetailRouter
    private var bird: Bird?

    // MARK: - Init

    init(router: BirdDetailRouter, birdDetailModel: BirdDetailModel) {
        self.router = router
        self.birdDetailModel = birdDetailModel
    }
}

extension BirdDetailPresenter: IBirdDetailPresenter {
    
    func didLoad(view: IBirdDetailView) {
        birdDetailView = view
        bird = birdDetailModel.bird
        birdDetailView?.setup(navigationTitle: bird?.name)
    }
    
    func showBirdConservationStatus() {
        //router.showConservationStatusModule(with: birdDetailModel.birdConservation, view: birdDetailView)
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
            return birdDetailModel.birdInfo.count
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
            cell.updateImage(birdDetailModel.birdImage)
            return cell
        case .birdInfo:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdInfoCell.reuseIdentifier, for: indexPath) as? BirdInfoCell else {
                return UICollectionViewCell() }
            let info = birdDetailModel.birdInfo[indexPath.item]
            cell.update(info: info)
            return cell
        }
    }
}
