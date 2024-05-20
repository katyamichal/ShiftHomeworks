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
        viewModel.setupController(self)
        viewModel.getData()
        setupActionForDissmissButton()
    }
    
    // MARK: - Setup method
    
    // MARK: - Setup method
    
    func setupConservationStatusView(with colourStatus: UIColor, description: String) {
        conservationStatusView.update(colour: colourStatus, conservationStatusDescription: description)
    }
    
    func setupStatusUpdate(with date: String) {
        conservationStatusView.updateLastUpdateLabel(date: date)
    }
    
    private func setupActionForDissmissButton() {
        conservationStatusView.setupActionForDissmisButton(target: self, action: #selector(dismissView))
    }
    
    @objc func dismissView() {
        viewModel.dismissView()
    }
}
