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
    
    weak var coordinator: Coordinator?
    private weak var view: ICarListView?
    private var cars: [CarListViewData] = []
    private let carService: CarServiceProtocol
    
    // MARK: - Init

    init(carService: CarServiceProtocol) {
        self.carService = carService
    }
}

extension CarListPresenter: ICarListPresenter {
    func showCarDetail(at index: Int) {
        let carId = cars[index].id
        (coordinator as? AppCoordinator)?.showCarDetailScene(with: carId)
    }
    
    func didLoad(view: ICarListView) {
        self.view = view
        getCars()
        self.view?.update(with: cars)
        self.view?.setupNavigationBar(with: "Choose Car")
    }
}

private extension CarListPresenter {
    func getCars() {
        guard let jsonCars = carService.loadCarsFromJSON() else { return }
        cars = jsonCars.map { car in
            CarListViewData(with: car.id, with: car.manufacturer)
        }
    }
}
