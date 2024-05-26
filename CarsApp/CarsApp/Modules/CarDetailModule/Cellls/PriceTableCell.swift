//
//  PriceTableCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class PriceTableCell: UITableViewCell {
    
    private let inset: CGFloat = 16
    
    static var reuseIdentifier: String {
        return String(describing: PriceTableCell.self)
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
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        return stackView
    }()

    private lazy var priceHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.text = "Price"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        return label
    }()
 
    // MARK: - Public
    
    func updatePriceLabel(with price: String) {
        priceLabel.text = price + "$"
    }
}

// MARK: - Setup methods

private extension PriceTableCell {
    func setupCell() {
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(priceHeaderLabel)
        stackView.addArrangedSubview(priceLabel)
    }
    
    func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       
    }
}
