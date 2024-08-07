//
//  ImageListViewController.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageView: AnyObject {
    func updateView()
    func showAlert(with type: Constants.AlerMessagesType)
    func deleteRow(at indexPath: IndexPath)
    func isReadyForLoading(with keyword: String, and id: UUID)
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
        setupSearchBar()
        presenter.viewDidLoaded(view: self)
        setupKeyboardBehavior()
    }
}

// MARK: - IImageView protocol methods

extension ImageListViewController: IImageView {
    func updateView() {
        imageView.tableView.reloadData()
    }
    
    func isReadyForLoading(with keyword: String, and id: UUID) {
        presenter.loadData(with: keyword, and: id)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        imageView.tableView.beginUpdates()
        imageView.tableView.deleteRows(at: [indexPath], with: .fade)
        imageView.tableView.endUpdates()
    }
    
    func showAlert(with type: Constants.AlerMessagesType) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRow(at: indexPath.row)
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

extension ImageListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.enablesReturnKeyAutomatically = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        imageView.searchBar.resignFirstResponder()
        guard let str = searchBar.text else {
            return
        }
        presenter.prepareForLoading(with: str)
    }
}

// MARK: - Private helper methods

private extension ImageListViewController {
    func setupTableViewDelegates() {
        imageView.tableView.delegate = self
        imageView.tableView.dataSource = self
    }
    
    func setupSearchBar() {
        imageView.searchBar.becomeFirstResponder()
        imageView.searchBar.delegate = self
    }
    
    func createDeleteAction(_ tableView: UITableView, at indexPath: IndexPath) -> UIContextualAction? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            self.presenter.deleteRow(at: indexPath)
        }
        deleteAction.image = UIImage(systemName: Constants.UIElementNameStrings.deleteActionImage)
        deleteAction.backgroundColor = .systemRed
        return deleteAction
    }
    
    func setupKeyboardBehavior() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandeling), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandeling), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardHandeling(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
        let adjustedContentInset: UIEdgeInsets
        if isKeyboardShowing {
            adjustedContentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        } else {
            adjustedContentInset = .zero
        }
        let animationDuration: Double = 0.2
        UIView.animate(withDuration: animationDuration) {
            self.imageView.tableView.contentInset = adjustedContentInset
            self.imageView.tableView.scrollIndicatorInsets = adjustedContentInset
        }
    }
}

