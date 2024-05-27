//
//  CarTableViewCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarTableViewCell: UITableViewCell {
    
    private let inset: CGFloat = 16
    private let topInset: CGFloat = 24
    
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(accessoryLabel)
        stackView.addArrangedSubview(manufacturerLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topInset).isActive = true
    }
}
