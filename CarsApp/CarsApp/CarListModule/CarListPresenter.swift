//
//  CarListPresenter.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation
protocol ICarListPresenter: AnyObject {
    func didLoad(view: ICarListView)
    func showCarDetail(at index: Int)
}

final class CarListPresenter {
    
    private weak var carListUIView: ICarListView?
    private var cars: [CarListViewData] = []
}

extension CarListPresenter: ICarListPresenter {
    func showCarDetail(at index: Int) {
     
    }
    
    func didLoad(view: ICarListView) {
        carListUIView = view
        getCars()
        carListUIView?.update(with: cars)
    }
}

private extension CarListPresenter {
    func getCars() {
    
    }
}
