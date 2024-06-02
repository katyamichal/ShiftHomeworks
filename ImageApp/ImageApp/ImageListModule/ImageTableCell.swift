//
//  ImageViewCell.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

final class ImageTableCell: UITableViewCell {
    
    private let inset: CGFloat = 32
    private let imageViewHeight: CGFloat = 300
    private let progressViewHeight: CGFloat = 3
    
    private enum LoadingImageViewStatus: String{
        case paused = "pause"
        case downloading = "xmark.circle"
    }
    
    static var reuseIdentifier: String {
        return String(describing: ImageTableCell.self)
    }
    
    var currentState: LoadingStatus = .nonActive {
        didSet {
            updateState()
        }
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
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var loadingProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.tintColor = .systemPink
        progressView.progressTintColor = .systemBlue
        return progressView
    }()
    //
    //    private lazy var pauseLoadingButton: UIButton = {
    //        let button = UIButton()
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.tintColor = .systemBlue
    //        let font = UIFont.systemFont(ofSize: 17)
    //        let configuration = UIImage.SymbolConfiguration(font: font)
    //        let unselectedImage = UIImage(systemName: "pause", withConfiguration: configuration)
    //        let selectedImage = UIImage(systemName: "xmark.circle", withConfiguration: configuration)
    //        button.setImage(unselectedImage, for: .normal)
    //        button.setImage(selectedImage, for: .selected)
    //        return button
    //    }()
    
    private lazy var pauseLoadingView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.color = .systemBlue
        return activityIndicator
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Public
    
    override func prepareForReuse() {
        loadingProgressView.progress = 0.0
        loadedImage.image = nil
        pauseLoadingView.image = nil
        messageLabel.text = nil
        super.prepareForReuse()
    }
    //
    //    func setupActionForPauseLoadigButton(target: Any, action: Selector, control event: UIControl.Event) {
    //        pauseLoadingButton.addTarget(target, action: action, for: event)
    //    }
}

// MARK: - Setup methods

private extension ImageTableCell {
    func setupCell() {
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(loadedImage)
        contentView.addSubview(loadingProgressView)
        contentView.addSubview(pauseLoadingView)
        contentView.addSubview(messageLabel)
        contentView.addSubview(activityIndicator)
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
        
        pauseLoadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        pauseLoadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        pauseLoadingView.bottomAnchor.constraint(equalTo: loadingProgressView.topAnchor, constant: -inset).isActive = true
        pauseLoadingView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pauseLoadingView.widthAnchor.constraint(equalTo: pauseLoadingView.heightAnchor, multiplier: 1).isActive = true
        
        
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -inset).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalTo: activityIndicator.heightAnchor, multiplier: 1).isActive = true
        
        messageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    private func updateState() {
        switch currentState {
            
        case .loading(let progress, let image):
            loadingProgressView.isHidden = false
            pauseLoadingView.isHidden = false
            pauseLoadingView.image = image
            loadingProgressView.progress = progress
            loadedImage.isHidden = true
            messageLabel.isHidden = true
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
        case .completed(let image):
            loadedImage.image = image
            loadedImage.isHidden = false
            loadingProgressView.isHidden = true
            pauseLoadingView.isHidden = true
            messageLabel.isHidden = true
            activityIndicator.isHidden = true
            
        case .failed(let message):
            loadingProgressView.isHidden = true
            pauseLoadingView.isHidden = true
            loadedImage.isHidden = true
            messageLabel.text = message
            activityIndicator.isHidden = true
            
        case .nonActive:
            loadingProgressView.isHidden = true
            pauseLoadingView.isHidden = true
            loadedImage.isHidden = true
            messageLabel.isHidden = true
            activityIndicator.isHidden = true
            
        case .paused(let image):
            loadingProgressView.isHidden = false
            pauseLoadingView.isHidden = false
            pauseLoadingView.image = image
            loadedImage.isHidden = true
            messageLabel.isHidden = true
            activityIndicator.isHidden = true
            
        case .waitToLoad(let message):
            loadingProgressView.isHidden = true
            pauseLoadingView.isHidden = true
            loadedImage.isHidden = true
            messageLabel.text = message
            messageLabel.isHidden = false
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }
    }
}
