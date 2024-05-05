//
//  ConservationStatusView.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class ConservationStatusView: UIView {
    
    private let inset: CGFloat = 30
    
    
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
        setupConstraints()
    }
    
    func setupConstraints() {
        conservationStatusLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
        conservationStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset).isActive = true
        conservationStatusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset).isActive = true
        conservationStatusLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset).isActive = true
    }
}
