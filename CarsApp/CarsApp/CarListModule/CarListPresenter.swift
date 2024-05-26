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
    private let carService: CarServiceProtocol
    
    // MARK: - Init

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }
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
        guard let jsonCars = carService.loadCarsFromJSON() else { return }
        jsonCars.forEach { car in
            cars.append(CarListViewData(with: car.id, with: car.manufacturer))
        }
    }
}
