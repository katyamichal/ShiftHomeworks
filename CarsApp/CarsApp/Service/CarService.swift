//
//  CarService.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation

private enum CarJsonUrlConstructor {
    static let resourceName = "Cars"
    static let fileExtension = "json"
}

protocol CarServiceProtocol: AnyObject {
    func loadCarsFromJSON() -> [Car]?
    func loadCarFromJSON(with id: Int, comletion: @escaping (Car?) -> Void)
}

final class CarServiceImp: CarServiceProtocol {
    private let jsonDecoder = JSONDecoder()
}

extension CarServiceImp {
    func loadCarsFromJSON() -> [Car]? {
        guard let jsonUrl = Bundle.main.url(forResource: CarJsonUrlConstructor.resourceName, withExtension: CarJsonUrlConstructor.fileExtension) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: jsonUrl)
            let jsonData = try jsonDecoder.decode(Cars.self, from: data)
            return jsonData.cars
        } catch {
            print("Error:\(error)")
        }
        return nil
    }
    
    func loadCarFromJSON(with id: Int, comletion: @escaping (Car?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            comletion(
                self.loadCarsFromJSON()?.first(where: {$0.id == id})
            )
        }
    }
}
