//
//  CarDetailPresenter.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import UIKit

final class CarDetailPresenter {
   
    weak var coordinator: Coordinator?
    private var service: CarServiceProtocol
    private weak var view: ICarDetailView?
    private var viewData: CarDetailViewData?
    private let id: Int
    private var currentBody: Body?
    
   private enum ImageViewStatus: String {
       case selected = "circle.fill"
       case nonSelected = "circle"
   }

    // MARK: - Init

    init(service: CarServiceProtocol, with id: Int) {
        self.service = service
        self.id = id
    }
}

extension CarDetailPresenter: ICarDetailPresenter {
    func viewIsReady() {
        loadCarData()
    }
    
    func didLoad(view: ICarDetailView) {
        self.view = view
    }
    
    func getSectionCount() -> Int {
        CarDetailSection.allCases.count
    }
    
    func getRowCountInSection(at section: Int) -> Int {
        let section = CarDetailSection.allCases[section]
        guard let viewData else { return 0 }
        switch section {
        case .carImage, .price:
            return 1
        case .bodyType:
            return viewData.body.count
        }
    }
    
    func cellForRow(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        cell(for: tableView, at: indexPath)
    }
    
    func viewForSectionHeader(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeader.reuseIdentifier) as? TableViewHeader else {
            return nil
        }
        let section = CarDetailSection.allCases[section]
        var title: String
        switch section {
        case .carImage:
            title = CarDetailSectionTitle.image.rawValue
        case .price:
            title = CarDetailSectionTitle.price.rawValue
        case .bodyType:
            title = CarDetailSectionTitle.bodyType.rawValue
        }
        view.updateTitle(with: title)
        return view
    }
    
    func calculatePrice(at index: IndexPath) {
        view?.updatePriceRowInSection(at: index)
    }
    
    func updateCurrentBodyType(with tableView: UITableView, at index: Int) {
        currentBody = viewData?.body[index]
        let carImageSectionIndex = CarDetailSection.carImage.rawValue
        let bodyTypeSectionIndex = CarDetailSection.bodyType.rawValue
        let sections: [Int] = [carImageSectionIndex, bodyTypeSectionIndex]
        let indexPaths = sections.flatMap { section -> [IndexPath] in
            indexPathsForRows(inSection: section, tableView: tableView)
        }
        view?.updateImageSectionWithBodyType(with: indexPaths)
    }
}

private extension CarDetailPresenter {
    func loadCarData() {
        view?.setLoading(enabled: true)
        service.loadCarFromJSON(with: id) { [weak self] car in
            guard let car else {
                return
            }
            DispatchQueue.main.async {
                self?.viewData = CarDetailViewData(id: car.id, body: car.body)
                self?.view?.setLoading(enabled: false)
                self?.updateView()
            }
        }
    }
    
    func updateView() {
        currentBody = viewData?.body.first
        view?.updateView()
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
            let imageStatus = viewData.body[indexPath.row].type == currentBody.type
            let imageName = imageStatus ? ImageViewStatus.selected : ImageViewStatus.nonSelected
            if  let image = UIImage(systemName: imageName.rawValue) {
                cell.updateImage(with: image)
            }
            cell.updateLabel(bodyType: viewData.body[indexPath.row].type.rawValue)
            return cell
        }
    }
    
    func indexPathsForRows(inSection section: Int, tableView: UITableView) -> [IndexPath] {
        let rowCount = tableView.numberOfRows(inSection: section)
        return (0..<rowCount).map { IndexPath(row: $0, section: section) }
    }
}
