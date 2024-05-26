//
//  BodyTypeTableCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class BodyTypeTableCell: UITableViewCell {
    
    private let inset: CGFloat = 16
    private let uiElementHeight: CGFloat = 100
    
    static var reuseIdentifier: String {
        return String(describing: BodyTypeTableCell.self)
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
        return imageView
    }()
    
    // MARK: - Public
    
    func updateLabel(bodyType: String) {
        bodyTypeName.text = bodyType
    }
    
    func updateImage(with status: Bool) {
        if status {
            selectionImageView.image = UIImage(named: "circle.fill")
        } else {
            selectionImageView.image = UIImage(named: "circle")
        }
    }
}

// MARK: - Setup methods

private extension BodyTypeTableCell {
    func setupCell() {
        contentView.addSubview(bodyTypeName)
        contentView.addSubview(selectionImageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        bodyTypeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        bodyTypeName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bodyTypeName.heightAnchor.constraint(equalToConstant: uiElementHeight).isActive = true
        
        selectionImageView.leadingAnchor.constraint(equalTo: bodyTypeName.trailingAnchor, constant: inset).isActive = true
        selectionImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectionImageView.heightAnchor.constraint(equalToConstant: uiElementHeight).isActive = true
        
    }
}
