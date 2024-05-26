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
    func updateNavigationTitle(with title: String)
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
    
    func updateNavigationTitle(with title: String) {
        navigationItem.title = title
    }
}

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCarDetail(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

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
