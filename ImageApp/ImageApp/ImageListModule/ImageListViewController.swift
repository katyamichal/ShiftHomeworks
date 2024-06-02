//
//  ImageListViewController.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit
protocol IImageView: AnyObject {
}

final class ImageListViewController: UIViewController, IImageView {

    private var imageView: ImageListView { return self.view as! ImageListView }
    private let presenter: IImageListPresenter
    
    // MARK: - Inits
    
    init(presenter: IImageListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Cycle
    
    override func loadView() {
        view = ImageListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewDelegates()
        setupTextFieldDelegate()
        presenter.viewDidLoaded(view: self)
    }
}

extension ImageListViewController: UITableViewDelegate {}

extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension ImageListViewController: UISearchTextFieldDelegate {}

private extension ImageListViewController {
    func setupTableViewDelegates() {
        imageView.tableView.delegate = self
        imageView.tableView.dataSource = self
    }
    
    func setupTextFieldDelegate() {
        imageView.searchTextField.delegate = self
    }
}

