//
//  ImageViewCell.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

final class ImageViewCell: UITableViewCell {
    
    private let inset: CGFloat = 32
    private let imageViewHeight: CGFloat = 300
    private let progressViewHeight: CGFloat = 8
    
    static var reuseIdentifier: String {
        return String(describing: ImageViewCell.self)
    }
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private lazy var loadedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "circle")
        imageView.isHidden = true
        return imageView
    }()
    
    private var loadingProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = .systemPink
        progressView.progressTintColor = .gray
        return progressView
    }()

   // private var activityView: UIView
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Public
    
    override func prepareForReuse() {
        loadedImage.image = nil
        loadingProgressView.progress = 0.0
        errorLabel.text = nil
        super.prepareForReuse()
    }
}

// MARK: - Setup methods

private extension ImageViewCell {
    func setupCell() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(loadedImage)
        contentView.addSubview(loadingProgressView)
        contentView.addSubview(errorLabel)
    }
    
    func setupConstraints() {
        loadedImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        loadedImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        loadedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        loadedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        loadedImage.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        
        loadingProgressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        loadingProgressView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loadingProgressView.heightAnchor.constraint(equalToConstant: progressViewHeight).isActive = true
        loadingProgressView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - inset).isActive = true
        
        errorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
