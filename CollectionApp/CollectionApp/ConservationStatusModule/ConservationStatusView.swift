//
//  ConservationStatusView.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class ConservationStatusView: UIView {
    
    private let inset: CGFloat = 30
    private let buttonAspectRation: CGFloat = 70
    
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI ELements
    
    private lazy var conservationStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .black
        config.title = "Got It"
        button.configuration = config
       
      //  button.setTitle("Got it", for: .normal)
        
        return button
    }()
    
    
    // MARK: - Public
    
    func update(colour: UIColor, conservationStatusDescription: String) {
        backgroundColor = colour.withAlphaComponent(0.9)
        conservationStatusLabel.text = conservationStatusDescription
    }
}


// MARK: - View Setups

private extension ConservationStatusView {
    
    func setupView() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(conservationStatusLabel)
        addSubview(dismissButton)
    }
    
    func setupConstraints() {
        conservationStatusLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
        conservationStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset).isActive = true
        conservationStatusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset).isActive = true
        
        dismissButton.topAnchor.constraint(equalTo: conservationStatusLabel.bottomAnchor,constant: inset).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: conservationStatusLabel.centerXAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: buttonAspectRation).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: buttonAspectRation).isActive = true

    }
}
