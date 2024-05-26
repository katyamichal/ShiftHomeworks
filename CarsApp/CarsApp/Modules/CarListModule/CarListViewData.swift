//
//  CarListViewData.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation

struct CarListViewData: Hashable {
    let id: Int
    let manufacturer: String
}

extension CarListViewData {
    init(with id: Int, with manufacturer: String) {
        self.id = id
        self.manufacturer = manufacturer
    }
}
