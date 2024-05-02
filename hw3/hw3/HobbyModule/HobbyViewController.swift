//
//  HobbyViewController.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit

final class HobbyViewController: UIViewController {
    
    private var hobbyView: HobbiesView { return self.view as! HobbiesView }
    private var hobbies = Hobby.createSampleData()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = HobbiesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hobbyView.updateView(hobbies)
    }
}
