//
//  IImageListPresenter.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 03.06.2024.
//

import UIKit

typealias IImageListPresenter = IImageListViewLifeCycle & IImageListLoading & IImageListTableViewHandler

protocol IImageListViewLifeCycle: AnyObject {
    func viewDidLoaded(view: IImageView)
}

protocol IImageListLoading: AnyObject {
    func loadData(with keyword: String)
}

protocol IImageListTableViewHandler: AnyObject {
    func getRowCountInSection() -> Int
    func rowForCell(tableView: UITableView, at index: IndexPath) -> UITableViewCell
    func updateRow(at index: Int)
    func heightForRow(at index: Int) -> CGFloat
    func permitDeleting(at index: IndexPath) -> Bool
    func deleteRow(at index: IndexPath)
}
