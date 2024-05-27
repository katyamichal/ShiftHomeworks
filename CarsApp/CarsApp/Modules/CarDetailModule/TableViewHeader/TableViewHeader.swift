//
//  TableViewHeader.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 27.05.2024.
//

import UIKit

final class TableViewHeader: UITableViewHeaderFooterView {
    
    static var reuseIdentifier: String {
        return String(describing: TableViewHeader.self)
    }
    
    private let inset: CGFloat = 16
    
    // MARK: - UI Element
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    // MARK: - Inits
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(with name: String) {
        titleLabel.text = name
    }
}

private extension TableViewHeader {
    func setupView() {
        addSubview(titleLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
