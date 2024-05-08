//
//  BirdDetailViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdDetailViewController: UIViewController {
    
    private var birdDetailView: BirdDetailView { return self.view as! BirdDetailView }
    private var birdDetailDataSource: BirdDetailCollectionDataSource
    private let navigationTitle: String
    private let birdConservation: BirdConservation
    
    
    // MARK: - Inits
    
    init(birdDetailDataSource: BirdDetailCollectionDataSource, navigationTitle: String, birdConservation: BirdConservation) {
        self.birdDetailDataSource = birdDetailDataSource
        self.navigationTitle = navigationTitle
        self.birdConservation = birdConservation
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
        birdDetailView.setupDataSource(birdDetailDataSource)
        setupNavigationBar()
    }
    
    // MARK: - Methods

    @objc func showBirdConservationStatus() {
        let controller = ConservationStatusViewController(birdConservation: birdConservation)
        self.present(controller, animated: true)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = navigationTitle
        let barButton = UIBarButtonItem(title: "Status", style: .plain, target: self, action: #selector(showBirdConservationStatus))
        navigationItem.rightBarButtonItem = barButton
    }
}
