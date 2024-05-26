//
//  CarListDetailViewController.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit
protocol ICarDetailView: AnyObject {
    func setLoading(enabled: Bool)
    func updateView()
    func updateCell(at indexPath: IndexPath)
}

final class CarDetailViewController: UIViewController {
    
    private var carDetailView: CarDetailView { return self.view as! CarDetailView }
    private let presenter: ICarDetailPresenter
        
    // MARK: - Inits
    
    init(presenter: ICarDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cycle
    
    override func loadView() {
        self.view = CarDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad(view: self)
        presenter.viewIsReady()
        
        carDetailView.tableView.dataSource = self
        carDetailView.tableView.delegate = self
    }
}

// MARK: - Collection Data Source

extension CarDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return presenter.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getRowCountInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.cellForRow(tableView: tableView, at: indexPath)
    }
}

private extension CarDetailViewController {
    func hideUI() {
        carDetailView.tableView.isHidden = true
    }
    
    func showUI() {
        carDetailView.tableView.isHidden = false
    }
}

extension CarDetailViewController: ICarDetailView {
    func updateCell(at indexPath: IndexPath) {
        let sectionsToReload = IndexSet([CarDetailSection.carImage.rawValue, CarDetailSection.bodyType.rawValue])
        carDetailView.tableView.reloadSections(sectionsToReload, with: .automatic)
    }
    
    func updateView() {
        carDetailView.tableView.reloadData()
    }
    
    func setLoading(enabled: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if enabled {
                hideUI()
                self.carDetailView.activityIndicator.startAnimating()
            } else {
                showUI()
                self.carDetailView.activityIndicator.stopAnimating()
            }
        }
    }
}

extension CarDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = CarDetailSection.allCases[indexPath.section]
        switch section {
        case .bodyType:
            presenter.updateBodyType(at: indexPath)
        case .carImage, .price:
            break
        }
    }
}
