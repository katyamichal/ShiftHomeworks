//
//  CarDetailPresenter.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit
protocol ICarDetailPresenter: AnyObject {
    func didLoad(view: ICarDetailView)
    func viewIsReady()
    
    func getSectionCount() -> Int
    func getRowCountInSection(at section: Int) -> Int
    func cellForRow(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    
    func updateBodyType(at index: IndexPath)
}

final class CarDetailPresenter {
   
    weak var coordinator: Coordinator?
    private weak var carDetailView: ICarDetailView?
    private var viewData: CarDetailViewData?
    private var service: CarServiceProtocol
    private let id: Int
    private var currentBody: Body?

    // MARK: - Init

    init(service: CarServiceProtocol, with id: Int) {
        self.service = service
        self.id = id
    }
}

extension CarDetailPresenter: ICarDetailPresenter {
    func updateBodyType(at index: IndexPath) {
        currentBody = viewData?.body[index.row]
        carDetailView?.updateCell(at: index)
    }
    
    func viewIsReady() {
        loadCarData()
    }
    
    func didLoad(view: ICarDetailView) {
        carDetailView = view
    }
    
    func getSectionCount() -> Int {
        CarDetailSection.allCases.count
    }
    
    func getRowCountInSection(at section: Int) -> Int {
        let section = CarDetailSection.allCases[section]
        guard let viewData else { return 0 }
        switch section {
        case .carImage:
            return 1
        case .price:
            return 1
        case .bodyType:
            return viewData.body.count
        }
    }
    
    func cellForRow(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let section = CarDetailSection.allCases[indexPath.section]
        switch section {
        case .carImage:
            return cell(for: tableView, at: indexPath)
        case .price:
            return cell(for: tableView, at: indexPath)
        case .bodyType:
            return cell(for: tableView, at: indexPath)
        }
    }
}

private extension CarDetailPresenter {
    func loadCarData() {
        carDetailView?.setLoading(enabled: true)
        service.loadCarFromJSON(with: id) { [weak self] car in
            guard let car else {
                return
            }
            DispatchQueue.main.async {
                self?.viewData = CarDetailViewData(id: car.id, body: car.body)
                self?.carDetailView?.setLoading(enabled: false)
                self?.updateView()
            }
        }
    }
    
    func updateView() {
        currentBody = viewData?.body.first
        carDetailView?.updateView()
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let section = CarDetailSection.allCases[indexPath.section]
        guard let viewData,  let currentBody else { return UITableViewCell() }
        
        switch section {
        case .carImage:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableCell.reuseIdentifier, for: indexPath) as? ImageTableCell else {
                return UITableViewCell()
            }
            cell.updateImage(currentBody.image)
            return cell
            
        case .price:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableCell.reuseIdentifier, for: indexPath) as? PriceTableCell else {
                return UITableViewCell()
            }
            cell.updatePriceLabel(with: "\(currentBody.price)")
            return cell
            
        case .bodyType:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BodyTypeTableCell.reuseIdentifier, for: indexPath) as? BodyTypeTableCell else {
                return UITableViewCell()
            }
            cell.updateLabel(bodyType: viewData.body[indexPath.row].type.rawValue)
            cell.updateImage(with: viewData.body[indexPath.row].type == currentBody.type)
            return cell
        }
    }
}
