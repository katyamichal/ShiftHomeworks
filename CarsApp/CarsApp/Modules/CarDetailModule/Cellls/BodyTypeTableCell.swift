//
//  BodyTypeTableCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class BodyTypeTableCell: UITableViewCell {
    
    private let inset: CGFloat = 16
    private let uiElementHeight: CGFloat = 40
    
    static var reuseIdentifier: String {
        return String(describing: BodyTypeTableCell.self)
    }
    
    private enum ImageViewStatus: String {
        case selected = "circle.fill"
        case nonSelected = "circle"
    }
    
    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private lazy var bodyTypeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    // MARK: - Public
    
    func updateLabel(bodyType: String) {
        bodyTypeName.text = bodyType.capitalized
    }
    
    func updateImage(with status: Bool) {
        let imageName = status ? ImageViewStatus.selected : ImageViewStatus.nonSelected
        selectionImageView.image = UIImage(systemName: imageName.rawValue)
    }
}

// MARK: - Setup methods

private extension BodyTypeTableCell {
    func setupCell() {
        selectionStyle = .none
        contentView.addSubview(bodyTypeName)
        contentView.addSubview(selectionImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        bodyTypeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        bodyTypeName.heightAnchor.constraint(equalToConstant: uiElementHeight).isActive = true
        bodyTypeName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        bodyTypeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        
        selectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset).isActive = true
        selectionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectionImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        selectionImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
