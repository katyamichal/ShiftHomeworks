//
//  BirdCollectionViewCell.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 05.05.2024.
//

import UIKit

class BirdCollectionViewCell: UICollectionViewCell {
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    // MARK: - Public
    
    func update(name: String, imageName: String) {
        birdName.text = name
        birdImageView.image = UIImage(named: imageName)
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
        birdName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        birdName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        birdName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        birdName.bottomAnchor.constraint(equalTo: birdImageView.topAnchor, constant: -20).isActive = true
        
        birdImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        birdImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        birdImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
