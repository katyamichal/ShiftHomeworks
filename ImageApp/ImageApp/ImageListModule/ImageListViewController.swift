//
//  ImageListViewController.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageView: AnyObject {
    func update()
    func showAlert(with type: Constants.AlerMessagesType)
    func deleteRow(at indexPath: IndexPath)
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
        setupTextField()
        presenter.viewDidLoaded(view: self)
    }
}
// MARK: - IImageView protocol methods

extension ImageListViewController: IImageView {
    func update() {
        imageView.tableView.reloadData()
    }
    
    func deleteRow(at indexPath: IndexPath) {
        imageView.tableView.beginUpdates()
        imageView.tableView.deleteRows(at: [indexPath], with: .fade)
        imageView.tableView.endUpdates()
    }
    
    func showAlert(with type: Constants.AlerMessagesType) {
        let alert = UIAlertController(title: type.title,
                                      message: type.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: type.buttonTitle, style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

// MARK: - TableView Delegate Methods

extension ImageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.updateRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        presenter.permitDeleting(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            guard let deleteAction = createDeleteAction(tableView, at: indexPath) else { return nil }
            let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
    }
    
    private func createDeleteAction(_ tableView: UITableView, at indexPath: IndexPath) -> UIContextualAction? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            self.presenter.deleteRow(at: indexPath)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        return deleteAction
    }
}

// MARK: - TableView Data Source Methods

extension ImageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getRowCountInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.rowForCell(tableView: tableView, at: indexPath)
    }
}

// MARK: - TextField Delegate Methods
#warning("responder")
extension ImageListViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        imageView.searchTextField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let str = textField.text else {
            return
        }
        presenter.loadData(with: str)
    }
}
// MARK: - Private helper methods

private extension ImageListViewController {
    func setupTableViewDelegates() {
        imageView.tableView.delegate = self
        imageView.tableView.dataSource = self
    }
    
    func setupTextField() {
        imageView.searchTextField.becomeFirstResponder()
        imageView.searchTextField.delegate = self
    }
}

