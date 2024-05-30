//
//  BirdDetailViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

protocol IBirdDetailView: AnyObject {
    func setup(navigationTitle: String?)
}

final class BirdDetailViewController: UIViewController {
    
    private var birdDetailView: BirdDetailView { return self.view as! BirdDetailView }
    private let presenter: IBirdDetailPresenter
    private var navigationTitle: String?
        
    // MARK: - Inits
    
    init(presenter: IBirdDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cycle
    
    override func loadView() {
        self.view = BirdDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birdDetailView.setupCollectionDataSource(self)
        setupNavigationBar()
        presenter.didLoad(view: self)
    }
}

private extension BirdDetailViewController {
    
    func setupNavigationBar() {
        navigationItem.title = navigationTitle
        let barButton = UIBarButtonItem(title: "Status", style: .plain, target: self, action: #selector(showBirdConservationStatus))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func showBirdConservationStatus() {
        guard let viewController = navigationController?.topViewController else { return }
        self.presenter.showBirdConservationStatus(with: viewController)
    }
}

// MARK: - Collection Data Source

extension BirdDetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.getSectionCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getItemsCountInSection(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter.itemForCell(collectionView: collectionView, at: indexPath)
    }
}


extension BirdDetailViewController: IBirdDetailView {
    func setup(navigationTitle: String?) {
        navigationItem.title = navigationTitle
    }
}
