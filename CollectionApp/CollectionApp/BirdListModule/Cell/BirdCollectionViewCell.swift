//
//  BirdCollectionViewCell.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

class BirdCollectionViewCell: UICollectionViewCell {
    
    private let topInset: CGFloat = 10
    private let inset: CGFloat = 20
    
    static var reuseIdentifier: String {
        return String(describing: BirdCollectionViewCell.self)
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstrains()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UIElements
    
    private lazy var birdName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var birdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // MARK: - Public
    
    func updateBirdImageView(_ name: String) {
        birdImageView.image = UIImage(named: name)
    }
    
    func updateBirdNameLabel(_ name: String) {
        birdName.text = name
    }
}


// MARK: - Setup Collection View Cell

private extension BirdCollectionViewCell {
    
    func setupCell() {
        setupViews()
        layer.borderColor = UIColor.systemYellow.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    func setupViews() {
        contentView.addSubview(birdName)
        contentView.addSubview(birdImageView)
    }
    
    func setupConstrains() {
        birdName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset).isActive = true
        birdName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        birdName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        birdName.bottomAnchor.constraint(equalTo: birdImageView.topAnchor, constant: -inset).isActive = true
        
        birdImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        birdImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        birdImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
