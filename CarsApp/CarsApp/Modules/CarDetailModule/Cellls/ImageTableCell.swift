//
//  ImageTableCell.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit
final class ImageTableCell: UITableViewCell {
    
    private let inset: CGFloat = 10
    
    static var reuseIdentifier: String {
        return String(describing: ImageTableCell.self)
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
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "sedan_image")
        return imageView
    }()
 
    // MARK: - Public
    
    func updateImage(_ name: String) {
        //carImageView.image = UIImage(named: name)
    }
}

// MARK: - Setup methods

private extension ImageTableCell {
    func setupCell() {
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        conteinerView.addSubview(carImageView)
        contentView.addSubview(conteinerView)
        
    }
    
    func setupConstraints() {
        conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset).isActive = true
        conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        conteinerView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        conteinerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
  
    }
}
