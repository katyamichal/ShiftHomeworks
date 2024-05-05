//
//  BirdImageCell.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

final class BirdImageCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: BirdImageCell.self)
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
    
    private let birdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    
    // MARK: - Public
    
    func update(imageName: String) {
        birdImageView.image = UIImage(named: imageName)
    }
}

// MARK: - Setup methods

private extension BirdImageCell {
    
    func setupCell() {
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(birdImageView)
    }
    
    func setupConstraints() {
        birdImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        birdImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        birdImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        birdImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}

