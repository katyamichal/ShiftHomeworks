//
//  IImageListPresenter.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 03.06.2024.
//

import UIKit

protocol IImageListPresenter: AnyObject {
    func viewDidLoaded(view: IImageView)
    func loadData(with keyword: String)
    func getRowCountInSection() -> Int
    func rowForCell(tableView: UITableView, at index: IndexPath) -> UITableViewCell
    func updateRow(at index: Int)
    func heightForRow(at index: Int) -> CGFloat
    func permitDeleting(at index: IndexPath) -> Bool
    func deleteRow(at index: IndexPath)
}
