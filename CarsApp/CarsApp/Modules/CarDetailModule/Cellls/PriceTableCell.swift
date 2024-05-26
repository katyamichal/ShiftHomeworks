//
//  PriceTableCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class PriceTableCell: UITableViewCell {
    
    private let inset: CGFloat = 10
    
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

    private lazy var priceHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.text = "Price"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .natural
        label.backgroundColor = .red
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
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(priceHeaderLabel)
        contentView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        
      
        priceHeaderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
       priceHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
       priceHeaderLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

       priceLabel.topAnchor.constraint(equalTo: priceHeaderLabel.bottomAnchor, constant: 8).isActive = true
       priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
       priceLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
  
    }
}
