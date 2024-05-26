//
//  CarTableViewCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarTableViewCell: UITableViewCell {
    
    private let inset: CGFloat = 16
    private let uiElementHeight: CGFloat = 100
    
    static var reuseIdentifier: String {
        return String(describing: CarTableViewCell.self)
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
    
    private lazy var accessoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🟢"
        return label
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
}

// MARK: - Setup methods

private extension CarTableViewCell {
    func setupCell() {
        contentView.addSubview(accessoryLabel)
        contentView.addSubview(manufacturerLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        accessoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        accessoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        accessoryLabel.heightAnchor.constraint(equalToConstant: uiElementHeight).isActive = true
        
        manufacturerLabel.leadingAnchor.constraint(equalTo: accessoryLabel.trailingAnchor, constant: inset).isActive = true
        manufacturerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        manufacturerLabel.heightAnchor.constraint(equalToConstant: uiElementHeight).isActive = true
        
    }
}
