//
//  CarTableViewCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarTableViewCell: UITableViewCell {
    
    private let inset: CGFloat = 16
    
    static var reuseIdentifier: String {
        return String(describing: CarTableViewCell.self)
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGreen
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private lazy var manufacturerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    // MARK: - Public
    
    func updateLabel(with manufacturer: String) {
        manufacturerLabel.text = manufacturer
    }
    
    override func prepareForReuse() {
        manufacturerLabel.text = nil
        super.prepareForReuse()
    }
}

// MARK: - Setup methods

private extension CarTableViewCell {
    func setupCell() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(accessoryImageView)
        stackView.addArrangedSubview(manufacturerLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset).isActive = true
    }
}
