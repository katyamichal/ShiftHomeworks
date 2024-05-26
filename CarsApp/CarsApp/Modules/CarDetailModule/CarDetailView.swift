//
//  CarDetailView.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit
final class CarDetailView: UIView {
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ImageTableCell.self, forCellReuseIdentifier: ImageTableCell.reuseIdentifier)
        tableView.register(PriceTableCell.self, forCellReuseIdentifier: PriceTableCell.reuseIdentifier)
        tableView.register(BodyTypeTableCell.self, forCellReuseIdentifier: BodyTypeTableCell.reuseIdentifier)
        return tableView
    }()
}

private extension CarDetailView {
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(activityIndicator)
        addSubview(tableView)
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
