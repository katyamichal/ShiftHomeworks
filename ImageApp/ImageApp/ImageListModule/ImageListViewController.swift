//
//  ImageListViewController.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageView: AnyObject {
  //  func update(at indexPaths: [IndexPath])
    func update()
}

final class ImageListViewController: UIViewController {

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
        presenter.getRowCountInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.rowForCell(tableView: tableView, at: indexPath)
    }
}

extension ImageListViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        imageView.searchTextField.resignFirstResponder()
          print("Search text: \(textField.text ?? "")")
          return true
      }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let str = textField.text else { return }
        presenter.loadData(with: str)
    }
}

private extension ImageListViewController {
    func setupTableViewDelegates() {
        imageView.tableView.delegate = self
        imageView.tableView.dataSource = self
    }
    
    func setupTextFieldDelegate() {
        imageView.searchTextField.delegate = self
    }
}

extension ImageListViewController: IImageView {
//    func update(at indexPath: [IndexPath]) {
//        imageView.tableView.reloadRows(at: indexPath, with: .fade)
//    }
    func update() {
        imageView.tableView.reloadData()
    }
}
