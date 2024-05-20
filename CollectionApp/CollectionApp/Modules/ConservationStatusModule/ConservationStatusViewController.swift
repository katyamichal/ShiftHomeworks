//
//  ConservationStatusViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class ConservationStatusViewController: UIViewController {
    
    private var conservationStatusView: ConservationStatusView { return self.view as! ConservationStatusView }
    private var viewModel: ConservationStatusViewModel
    
    
    // MARK: - Inits
    
    init(viewModel: ConservationStatusViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    
    override func loadView() {
        self.view = ConservationStatusView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        setupConservationStatusView()
        setupActionForDissmissButton()
    }
    
    // MARK: - Setup method
    
    private func setupConservationStatusView() {
        conservationStatusView.update(colour: birdConservation.conservationStatus, conservationStatusDescription: birdConservation.conservationStatusDescription)
    }
    
    private func setupActionForDissmissButton() {
        conservationStatusView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        dismiss(animated: true)
    }
}
