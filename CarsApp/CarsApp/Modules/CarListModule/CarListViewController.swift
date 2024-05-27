//
//  CarListViewController.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

private enum Section {
    case cars
}

protocol ICarListView: AnyObject {
    func update(with cars: [CarListViewData])
    func setupNavigationBar(with title: String)
}

final class CarListViewController: UIViewController {
    
    private var carListView: CarListView { return self.view as! CarListView }
    private let presenter: ICarListPresenter
    private var tableViewDiffableDataSource: UITableViewDiffableDataSource<Section, CarListViewData>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, CarListViewData>()
    
    // MARK: - Inits
    
    init(presenter: ICarListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cycle
    
    override func loadView() {
        view = CarListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carListView.tableView.delegate = self
        presenter.didLoad(view: self)
    }
}

extension CarListViewController: ICarListView {
    func update(with cars: [CarListViewData]) {
        configureTableViewDataSource()
        applySnapshot(with: cars)
    }
    
    func setupNavigationBar(with title: String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = title
    }
}
// MARK: - TableView Delegate

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.showCarDetail(at: indexPath.row)
    }
}

// MARK: - TableView Data Source

private extension CarListViewController {
    func configureTableViewDataSource() {
        tableViewDiffableDataSource = UITableViewDiffableDataSource<Section, CarListViewData>(tableView: carListView.tableView) { (tableView, indexPath, car) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.reuseIdentifier, for: indexPath) as? CarTableViewCell else {
                return UITableViewCell()
            }
            cell.updateLabel(with: car.manufacturer)
            return cell
        }
    }
    
    func applySnapshot(with cars: [CarListViewData]) {
        snapshot.appendSections([.cars])
        snapshot.appendItems(cars, toSection: .cars)
        tableViewDiffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}
