//
//  HobbySingleView.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit


final class HobbySingleView: UIView {
    
    private let inset: CGFloat = 16
    private let hobbyLabelFontName = "Avenir Next Regular"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var hobbyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: hobbyLabelFontName, size: 23)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultHigh - 1, for: .vertical)
        return imageView
    }()
    
    private lazy var hobbyDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: hobbyLabelFontName, size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    func update(_ hobby: Hobby) {
        hobbyName.text = hobby.name
        hobbyDescription.text = hobby.description
        imageView.image = UIImage(named: hobby.image)
    }
}


private extension HobbySingleView {
    
    func setupView() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(hobbyName)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(hobbyDescription)
    }
    
    func setupConstraints() {
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
    }
}
