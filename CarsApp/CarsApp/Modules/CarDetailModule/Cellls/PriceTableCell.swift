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
        
    // MARK: - UI Element
    
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
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
       
    }
}
