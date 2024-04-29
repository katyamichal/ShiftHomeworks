//
//  HobbyView.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit

final class HobbiesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements

    private let scrollView = UIScrollView()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        return pageControl
    }()
    
    
    private func setupScrollViewPages(_ hobbyInfo: [Hobby]) {
        scrollView.frame = CGRect(x: .zero, y: .zero, width: Layout.width, height: Layout.height / 1.3)
        scrollView.contentSize = CGSize(width: Layout.width * CGFloat(Float(hobbyInfo.count)), height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = hobbyInfo.count
        hobbyInfo.enumerated().map { index, hobbyItem -> HobbySingleView in
            let view = HobbySingleView(frame: CGRect(
                x: CGFloat(index) * Layout.width,
                y: 10,
                width: Layout.width,
                height: scrollView.frame.size.height))
            view.update(hobbyItem)
            scrollView.addSubview(view)
            return view
        }
    }
    
    @objc
    private func pageControlDidChange(_ sender: UIPageControl) {
        let current = CGFloat(sender.currentPage)
        scrollView.setContentOffset(CGPoint(x: current * (window?.frame.size.width ?? 100), y: 0), animated: true)
    }
    
    // MARK: - Public

    func updateView(_ hobbies: [Hobby]) {
        setupScrollViewPages(hobbies)
        pageControl.numberOfPages = hobbies.count
    }
}

private extension HobbiesView {
    
    func setupView() {
        backgroundColor = .secondarySystemBackground
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(scrollView)
        addSubview(pageControl)
        
    }
    
    func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        pageControl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

extension HobbiesView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        if offsetY <= 0 && scrollView.contentOffset.x > 0 {
            pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width)))
        }
    }
}

