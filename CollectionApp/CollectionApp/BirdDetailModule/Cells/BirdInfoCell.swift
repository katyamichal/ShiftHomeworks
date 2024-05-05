//
//  BirdInfoCell.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

class BirdInfoCell: UICollectionViewCell {
    
    private let inset: CGFloat = 10
    
    static var reuseIdentifier: String {
        return String(describing: BirdInfoCell.self)
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Elements
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        return label
    }()
    
    // MARK: - Public
    
    func update(info: String) {
        infoLabel.text = info
    }
}


// MARK: - Setup methods

private extension BirdInfoCell {
    
    func setupCell() {
        contentView.backgroundColor = .yellow.withAlphaComponent(0.6)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(infoLabel)
    }
    
    func setupConstraints() {
        infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
    }
}
