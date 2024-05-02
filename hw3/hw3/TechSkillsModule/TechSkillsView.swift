//
//  TechSkillsView.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit


final class TechSkillsView: UIView {
    
    private let inset: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "coding")
        return imageView
    }()
    
    private var visualEffect: UIVisualEffectView = {
        let vev = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        vev.translatesAutoresizingMaskIntoConstraints = false
        return vev
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = true
        return textView
    }()
    
    
    // MARK: - Public
    
    func update(_ techSkills: [TechSkill]) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.firstLineHeadIndent = 5.0
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .paragraphStyle: paragraphStyle
        ]
        let localizedStrings = techSkills.map { NSLocalizedString($0.question, comment: "") + "\t\n" + NSLocalizedString($0.answer, comment: "") }
        let attributedString = NSMutableAttributedString(string: localizedStrings.joined(separator: "\n"), attributes: attributes)
        textView.attributedText = attributedString
    }
}

private extension TechSkillsView {

    func setupView() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(backgroundImageView)
        addSubview(visualEffect)
        visualEffect.contentView.addSubview(textView)
    }
    
    func setupConstraints() {
        
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        visualEffect.topAnchor.constraint(equalTo: backgroundImageView.topAnchor).isActive = true
        visualEffect.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor).isActive = true
        visualEffect.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor).isActive = true
        visualEffect.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        
        
        textView.topAnchor.constraint(equalTo: visualEffect.safeAreaLayoutGuide.topAnchor, constant: inset).isActive = true
        textView.leadingAnchor.constraint(equalTo: visualEffect.safeAreaLayoutGuide.leadingAnchor, constant: inset).isActive = true
        textView.trailingAnchor.constraint(equalTo: visualEffect.safeAreaLayoutGuide.trailingAnchor, constant: -inset).isActive = true
        textView.bottomAnchor.constraint(equalTo: visualEffect.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}
