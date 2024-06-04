//
//  CarDetailView.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarDetailView: UIView {
    
    private let inset: CGFloat = 16
    private let buttonHeight: CGFloat = 50
    
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
        tableView.separatorStyle = .none
        tableView.register(ImageTableCell.self, forCellReuseIdentifier: ImageTableCell.reuseIdentifier)
        tableView.register(PriceTableCell.self, forCellReuseIdentifier: PriceTableCell.reuseIdentifier)
        tableView.register(BodyTypeTableCell.self, forCellReuseIdentifier: BodyTypeTableCell.reuseIdentifier)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseIdentifier)
        return tableView
    }()
    
    lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.tertiarySystemBackground, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setTitle("Calculate price", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = buttonHeight / 2
        return button
    }()
    
    // MARK: -  Setup method for calculate button
    
    func setupActionForCalculateButton(target: Any?, action: Selector, for event: UIControl.Event = .touchUpInside) {
        calculateButton.addTarget(target, action: action, for: event)
    }
}

// MARK: - Setup Methods

private extension CarDetailView {
    func setupView() {
        backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(activityIndicator)
        addSubview(tableView)
        addSubview(calculateButton)
    }
    
    func setupConstraints() {
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: calculateButton.topAnchor, constant: -inset).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        calculateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset).isActive = true
        calculateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
        calculateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
        calculateButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
}
