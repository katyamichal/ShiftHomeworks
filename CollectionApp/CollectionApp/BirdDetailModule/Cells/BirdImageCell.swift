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
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var birdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(birdImageView)
    }
    
    func setupConstraints() {
        conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        birdImageView.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor).isActive = true
        birdImageView.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor).isActive = true
        birdImageView.heightAnchor.constraint(equalTo: conteinerView.heightAnchor).isActive = true
    }
}

