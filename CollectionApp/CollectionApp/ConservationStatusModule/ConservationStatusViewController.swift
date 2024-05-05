//
//  ConservationStatusViewController.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class ConservationStatusViewController: UIViewController {
    
    private var colour: UIColor
    private var conservationStatusDescription: String
    private var conservationStatusView: ConservationStatusView { return self.view as! ConservationStatusView }
    
    
    // MARK: - Inits
    
    init(colour: UIColor, conservationStatusDescription: String) {
        self.colour = colour
        self.conservationStatusDescription = conservationStatusDescription
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
        setupConservationStatusView()
    }
    
    // MARK: - Setup method
    
    private func setupConservationStatusView() {
        conservationStatusView.update(colour: colour, conservationStatusDescription: conservationStatusDescription)
    }
}
