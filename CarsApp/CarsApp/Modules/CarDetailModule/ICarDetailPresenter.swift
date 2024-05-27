//
//  ICarDetailPresenter.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 27.05.2024.
//

import UIKit

typealias ICarDetailPresenter = ICarDetailViewLifecycle & ICarDetailTableViewDataSource & ICarDetailBusinessLogic

protocol ICarDetailViewLifecycle: AnyObject {
    func didLoad(view: ICarDetailView)
    func viewIsReady()
}

protocol ICarDetailTableViewDataSource: AnyObject {
    func getSectionCount() -> Int
    func getRowCountInSection(at section: Int) -> Int
    func cellForRow(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func viewForSectionHeader(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
}

protocol ICarDetailBusinessLogic: AnyObject {
    func updateCurrentBodyType(at index: IndexPath)
    func calculatePrice(at index: IndexPath)
}
